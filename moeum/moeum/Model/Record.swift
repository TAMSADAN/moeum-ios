//
//  Record.swift
//  moeum
//
//  Created by 송영모 on 2022/04/06.
//

import Foundation

struct Record {
    var id: Int = 0
    var type: String = ""
    var tag: String = ""
    var item: String = ""
    var price: Double = 0.0
    var count: Double = 0.0
    var date: Date = Date()
    var memo: String = ""
    
    mutating func set(id: Int = 0, tag: String, type: String, item: String, price: Double, count: Double, date: Date, memo: String) {
        self.id = id
        self.type = type
        self.tag = tag
        self.item = item
        self.price = price
        self.count = count
        self.date = date
        self.memo = memo
    }
}
