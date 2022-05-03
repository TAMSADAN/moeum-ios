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
        var dates: [Date] = []
        var date: Date = Date()
        var dc = self.getKstDateComponents()
        
        dc.day = 1
        dc.hour = 12
        date = dc.date!
        print(date.getKstDateComponents().weekday)
        while date.getKstDateComponents().weekday! != 1 {
            date = date.plusPeriod(Period.day, interval: -1)
            dates.append(date)
        }
        
        dates = dates.reversed()
        dc.day = 1
        date = dc.date!
        while date.getKstDateComponents().month == dc.month || date.getKstDateComponents().weekday != 1{
            dates.append(date)
            date = date.plusPeriod(Period.day, interval: 1)
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
    
    func isEqualPeriod(_ period: Period = Period.day, date: Date) -> Bool {
        let c1 = self.getKstDateComponents()
        let c2 = date.getKstDateComponents()

        if period == Period.day {
            return c1.year! == c2.year! && c1.month! == c2.month! && c1.day! == c2.day!
        } else if period == Period.week {
            return c1.weekOfYear! == c2.weekOfYear!
        } else if period == Period.month {
            return c1.month! == c2.month!
        } else if period == Period.year {
            return c1.year! == c2.year
        } else {
            return false
        }
    }
    
    func plusPeriod(_ period: Period = Period.day, interval: Int) -> Date {
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
            return "\(String(dc.month!))\'\(String(dc.weekOfMonth!))"
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
    
    func getCalendarDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.M"
        
        return dateFormatter.string(from: getKstDateComponents().date!)
    }
    
    func getCalendarBottomSheetDateString() -> String {
        let weeks = ["","일","월", "화", "수", "목", "금", "토"]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M.d"
        var string = dateFormatter.string(from: getKstDateComponents().date!)
        string += "(\(weeks[getKstDateComponents().weekday!]))"
        
        return string
    }
    
    func getKstDateComponents() -> DateComponents {
        return Calendar.current.dateComponents(in: TimeZone(abbreviation: "KST")!, from: self)
    }
}
