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
        input.records
            .bind(to: output.records)
            .disposed(by: disposeBag)
        
        input.isMonthLabelClicked
            .bind(to: output.datePickerOpen)
            .disposed(by: disposeBag)
        
        input.datePickerDate
            .withUnretained(self)
            .bind { owner, date in
                let dateComponents = Calendar.current.dateComponents([.year, .month], from: date)
                let monthLabeltext = String(dateComponents.year!) + "." + String(dateComponents.month!)
                owner.output.monthLabelText.accept(monthLabeltext)
                owner.output.calendarDates.accept(owner.getDatesOfMonth(date: date))
            }
            .disposed(by: disposeBag)
        
        input.calendarSelectedCellData
            .withUnretained(self)
            .bind { owner, data in
                owner.output.bottomSheetRecords.accept(data.2)
                owner.output.bottomSheetDate.accept(data.1)
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(output.calendarDates, output.records)
            .withUnretained(self)
            .bind { owner, data in
                var cellDatas: [(Date, [Record])] = []
                for date in data.0 {
                    var newRecords: [Record] = []
                    for record in data.1 {
                        if record.date.isEqualDate(date: date) {
                            newRecords.append(record)
                        }
                    }
                    cellDatas.append((date, newRecords))
                }
                owner.output.calendarCellDatas.accept(cellDatas)
            }
            .disposed(by: disposeBag)
        
//        Observable.combineLatest(output.calendarDates, output.records)
//            .map { [weak self] dates, records in
//                var cellDatas: [(Date, [Record])] = []
//                for date in dates {
//                    var newRecords: [Record] = []
//                    for record in records {
//                        if self?.isEqualDate(date1: date, date2: record.date) ?? false {
//                            newRecords.append(record)
//                        }
//                    }
//                    cellDatas.append((date, newRecords))
//                }
//                return cellDatas
//            }
//            .bind(to: output.cellDatas)
//            .disposed(by: disposeBag)
    }
}

extension CalendarViewModel {
    func getDatesOfMonth(date: Date) -> [Date] {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "KST")!
        
        var dateComponents = calendar.dateComponents(in: TimeZone(abbreviation: "KST")!, from: date)
        
        dateComponents.day = 1
        var date = dateComponents.date!
        
        dateComponents.month = dateComponents.month! + 1
        let endDate = calendar.date(byAdding: .day, value: -1, to: dateComponents.date!)!
        
        var dates: [Date] = []
        
        
        var weekOfStartDate = Int(calendar.dateComponents([.weekday], from: date).weekday ?? 0)
        weekOfStartDate = weekOfStartDate == 1 ? 2 : weekOfStartDate
        
        date = calendar.date(byAdding: .day, value: -weekOfStartDate, to: date)!
        
        while date < endDate {
            date = calendar.date(byAdding: .day, value: 1, to: date)!
            dates.append(date)
        }
        return dates
    }
    
    func isEqualDate(date1: Date, date2: Date) -> Bool {
        let c1 = Calendar.current.dateComponents(in: TimeZone(abbreviation: "KST")!, from: date1)
        let c2 = Calendar.current.dateComponents(in: TimeZone(abbreviation: "KST")!, from: date2)
        
        if c1.year == c2.year && c1.month == c2.month && c1.day == c2.day {
            return true
        } else {
            return false
        }
    }
}
