//
//  Record.swift
//  moeum
//
//  Created by 송영모 on 2022/04/06.
//

import Foundation

struct Record {
    var id: Int = -1
    var type: String = ""
    var tag: String = ""
    var item: String = ""
    var price: Double = 0.0
    var count: Double = 0.0
    var date: Date = Date()
    var memo: String = ""
    
    mutating func set(id: Int = -1, tag: String, type: String, item: String, price: Double, count: Double, date: Date, memo: String) {
        self.id = id
        self.type = type
        self.tag = tag
        self.item = item
        self.price = price
        self.count = count
        self.date = date
        self.memo = memo
    }
    
    func isEqaulUnit(_ record: Record, unit: Unit) -> Bool {
        if unit == Unit.type {
            return self.type == record.type
        } else if unit == Unit.item {
            return self.item == record.item
        } else if unit == Unit.tag {
            return self.tag == record.tag
        } else if unit == Unit.day {
            return self.date.isEqualPeriod(Period.day, date: record.date)
        } else if unit == Unit.week {
            return self.date.isEqualPeriod(Period.week, date: record.date)
        } else if unit == Unit.month {
            return self.date.isEqualPeriod(Period.month, date: record.date)
        } else if unit == Unit.year {
            return self.date.isEqualPeriod(Period.year, date: record.date)
        } else {
            return false
        }
        
    }
}

struct RecordChartData {
    var item: String = String()
    var date: Date = Date()
    var income: Double = Double()
    var rate: Double = Double()
}

struct ChartData {
    var points: [String] = []
    var values: [Double] = []
}
