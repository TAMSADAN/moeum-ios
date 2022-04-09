//
//  CalendarVM+Bind.swift
//  moeum
//
//  Created by 송영모 on 2022/04/08.
//

import Foundation
import RxSwift
import RxCocoa

extension CalendarViewModel {
    func setBind() {
        input.isClickedDatePickerButton
            .bind(to: output.datePickerOpen)
            .disposed(by: disposeBag)
        
        input.nowDate
            .subscribe(onNext: {[weak self] date in
                let dateComponents = Calendar.current.dateComponents([.year, .month], from: date)
                let dateStr = String(dateComponents.year!) + "." + String(dateComponents.month!)
                self?.output.dateLabel.accept(dateStr)
                self?.output.dates.accept(self?.getDatesOfMonth(date: date) ?? [])
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(output.dates, input.records)
            .map { [weak self] dates, records in
                var cellDatas: [(Date, [Record])] = []
                for date in dates {
                    var newRecords: [Record] = []
                    for record in records {
                        if self?.isEqualDate(date1: date, date2: record.date) ?? false {
                            newRecords.append(record)
                        }
                    }
                    cellDatas.append((date, newRecords))
                }
                print(cellDatas)
                return cellDatas
            }
            .bind(to: output.cellDatas)
            .disposed(by: disposeBag)
    }
}
