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
            })
            .disposed(by: disposeBag)
        
//        Observable.combineLatest(input.dates, input.records)
//            .subscribe(onNext: { data in
//                for date in data.0 {
//                    for record in data.1 {
//                        record.
//                    }
//                    print(date)
//                }
//            })
//            .disposed(by: disposeBag)
    }
}
