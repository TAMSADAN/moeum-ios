//
//  Calendar.swift
//  Toolinder
//
//  Created by 송영모 on 2022/05/03.
//

import Foundation

struct CalendarItemZip {
    var calendarItems: [CalendarItem] = []
}

struct CalendarItem {
    var isThisMonth: Bool = true
    var date: Date = Date()
    var records: [Record] = []
}
