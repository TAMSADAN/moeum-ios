//
//  CalendarVM+Logic.swift
//  moeum
//
//  Created by 송영모 on 2022/04/08.
//

import Foundation

extension CalendarViewModel {
    func getDatesOfMonth(date: Date) -> [Date] {
        var date = date.startOfMonth
        let endDate = date.endOfMonth
        
        var dates: [Date] = []
        let weekOfStartDate = Int(Calendar.current.dateComponents([.weekday], from: date).weekday ?? 0)
        
        date = Calendar.current.date(byAdding: .day, value: -weekOfStartDate + 1, to: date)!
        
        while date <= endDate {
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            dates.append(date)
        }
        return dates
    }
    
    func isEqualDate(date1: Date, date2: Date) -> Bool {
        let c1 = Calendar.current.dateComponents([.year, .month, .day], from: date1)
        let c2 = Calendar.current.dateComponents([.year, .month, .day], from: date2)
        
        if c1.year == c2.year && c1.month == c2.month && c1.day == c2.day {
            return true
        } else {
            return false
        }
    }
}
