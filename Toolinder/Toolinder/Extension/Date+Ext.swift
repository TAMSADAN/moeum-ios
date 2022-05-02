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
        let c1 = self.getKstDateComponents()
        let c2 = date.getKstDateComponents()
        
        if c1.year == c2.year && c1.month == c2.month && c1.day == c2.day {
            return true
        } else {
            return false
        }
    }
    
    func isFastDate(date: Date, compareDate: Date) -> Int {
        let c1 = date.getKstDateComponents()
        let c2 = compareDate.getKstDateComponents()
        
        if c1.date! < c2.date! {
            return 1
        } else {
            return 0
        }
    }
    
    func isBetween(start: Date, end: Date) -> Bool {
        let c1 = self.getKstDateComponents()
        let c2 = start.getKstDateComponents()
        let c3 = end.getKstDateComponents()
        
        if c1.date! > c2.date! && c1.date! < c3.date! {
            return true
        } else {
            return false
        }
    }
    
    func isEqualPeriod(_ date: Date, period: Period) -> Bool {
        let c1 = self.getKstDateComponents()
        let c2 = date.getKstDateComponents()

        if period == Period.day {
            return c1.year! == c2.year! && c1.month! == c2.month! && c1.day! == c2.day!
        } else if period == Period.week {
            return c1.yearForWeekOfYear! == c2.yearForWeekOfYear!
        } else if period == Period.month {
            return c1.month! == c2.month!
        } else if period == Period.year {
            return c1.year! == c2.year
        } else {
            return false
        }
    }
    
    func plusDay(_ day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: self)!
    }
    
    func plusWeek(_ week: Int) -> Date {
        return Calendar.current.date(byAdding: .weekOfYear, value: week, to: self)!
    }
    
    func plusMonth(_ month: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: month, to: self)!
    }
    
    func plusYear(_ year: Int) -> Date {
        return Calendar.current.date(byAdding: .year, value: year, to: self)!
    }
    
    func plusPeriod(_ interval: Int, period: Period) -> Date {
        if period == Period.day {
            return Calendar.current.date(byAdding: .day, value: interval, to: self)!
        } else if period == Period.week {
            return Calendar.current.date(byAdding: .weekOfYear, value: interval, to: self)!
        } else if period == Period.month {
            return Calendar.current.date(byAdding: .month, value: interval, to: self)!
        } else if period == Period.year {
            return Calendar.current.date(byAdding: .year, value: interval, to: self)!
        } else {
            return Date()
        }
    }
    
    func getStringPeriod(period: Period) -> String {
        let dc = self.getKstDateComponents()
        
        if period == Period.day {
            return "\(String(dc.month!)).\(String(dc.day!))"
        } else if period == Period.week {
            return "\(String(dc.month!))'\(String(dc.weekOfMonth!))"
        } else if period == Period.month {
            return "\(String(dc.month!))"
        } else if period == Period.year {
            return "\(String(dc.year!))"
        } else {
            return ""
        }
    }
    
    func getString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd HH:mm"
        
        return dateFormatter.string(from: self)
    }
    
    func getDates(start: Date, end: Date) -> [Date] {
        let startDate = start.getKstDateComponents().date!
        let endDate = end.getKstDateComponents().date!
        var date = startDate
        var dates: [Date] = []
        
        while date < endDate {
            dates.append(date)
            date = date.plusDay(1)
        }
        return dates
    }
    
    func getKstDateComponents() -> DateComponents {
        return Calendar.current.dateComponents(in: TimeZone(abbreviation: "KST")!, from: self)
    }
}
