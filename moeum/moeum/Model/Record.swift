//
//  Record.swift
//  moeum
//
//  Created by 송영모 on 2022/04/06.
//

import Foundation

struct Record {
    var id: Int = 0
    var tagName: String = ""
    var itemName: String = ""
    var buyPrice: String = ""
    var sellPrice: String = ""
    var buyCount: String = ""
    var sellCount: String = ""
    var buyDate: Date = Date(timeIntervalSince1970: 0)
    var sellDate: Date = Date(timeIntervalSince1970: 0)
    var memo: String = ""
    
    mutating func update(tagName: String, itemName: String, buyPrice: String, sellPrice: String, buyCount: String, sellCount: String, buyDate: Date, sellDate: Date, memo: String) {
        self.tagName = tagName
        self.itemName = itemName
        self.buyPrice = buyPrice
        self.sellPrice = sellPrice
        self.buyCount = buyCount
        self.sellCount = sellCount
        self.buyDate = buyDate
        self.sellDate = sellDate
        self.memo = memo
    }
}
