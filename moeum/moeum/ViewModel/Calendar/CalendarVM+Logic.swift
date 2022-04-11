//
//  CalendarVM+Logic.swift
//  moeum
//
//  Created by 송영모 on 2022/04/08.
//

import Foundation

extension CalendarViewModel {
    func getDatesOfMonth(date: Date) -> [Date] {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "KST")!
        
        var dateComponents = calendar.dateComponents(in: TimeZone(abbreviation: "KST")!, from: date)
        
        dateComponents.day = 1
        var date = dateComponents.date!
        
        dateComponents.month = dateComponents.month! + 1
        let endDate = calendar.date(byAdding: .day, value: -1, to: dateComponents.date!)!
        
        print(date, endDate)
        
        
        
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
