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

        while date <= endDate {
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            dates.append(date)
        }
        
        return dates
    }
}
