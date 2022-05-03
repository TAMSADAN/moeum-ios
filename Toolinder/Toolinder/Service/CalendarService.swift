//
//  CalendarService.swift
//  Toolinder
//
//  Created by 송영모 on 2022/05/03.
//

import Foundation

class CalendarService {
    let recordService = RecordService()
    
    func getCalendarItems(date: Date = Date()) -> [CalendarItem] {
        let dates = date.getDatesOfMonth()
        let records = recordService.getRecords()
        var calendarItems: [CalendarItem] = []
        
        for d in dates {
            var newRecords: [Record] = []
            for record in records {
                if d.isEqualPeriod(Period.day, date: record.date) {
                    newRecords.append(record)
                }
            }
            if d.isEqualPeriod(Period.month, date: date) {
                calendarItems.append(CalendarItem(isThisMonth: true, date: d, records: newRecords))
            } else {
                calendarItems.append(CalendarItem(isThisMonth: false, date: d, records: newRecords))
            }
        }
        return calendarItems
    }
}
