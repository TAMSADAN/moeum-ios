//
//  Date+Ext.swift
//  moeum
//
//  Created by 송영모 on 2022/04/08.
//

import Foundation

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var startOfMonth: Date {
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)
        
        return  calendar.date(from: components)!
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }
    
    func getDatesOfMonth() -> [Date] {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "KST")!
        
        var dateComponents = calendar.dateComponents(in: TimeZone(abbreviation: "KST")!, from: self)
        
        dateComponents.timeZone = TimeZone(abbreviation: "KST")!
        
        dateComponents.day = 0
        var date = dateComponents.date!
        
        dateComponents.month = dateComponents.month! + 1
        dateComponents.day = 1
        let endDate = calendar.date(byAdding: .day, value: -1, to: dateComponents.date!)!
        
        var dates: [Date] = []
        
        while date < endDate {
            date = calendar.date(byAdding: .day, value: 1, to: date)!
            dates.append(date)
        }
        return dates
    }
    
    func isEqualDate(date: Date) -> Bool {
        let c1 = Calendar.current.dateComponents(in: TimeZone(abbreviation: "KST")!, from: self)
        let c2 = Calendar.current.dateComponents(in: TimeZone(abbreviation: "KST")!, from: date)
        
        if c1.year == c2.year && c1.month == c2.month && c1.day == c2.day {
            return true
        } else {
            return false
        }
    }
    
    func isFastDate(date: Date, compareDate: Date) -> Int {
        let c1 = Calendar.current.dateComponents(in: TimeZone(abbreviation: "KST")!, from: date)
        let c2 = Calendar.current.dateComponents(in: TimeZone(abbreviation: "KST")!, from: compareDate)
        
        if c1.date! < c2.date! {
            return 1
        } else {
            return 0
        }
    }
    
    func getString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd HH:mm"
        
        return dateFormatter.string(from: self)
    }
}
