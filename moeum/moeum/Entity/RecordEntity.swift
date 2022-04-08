//
//  RecordEntity.swift
//  moeum
//
//  Created by 송영모 on 2022/04/06.
//
import Foundation
import RealmSwift

class RecordEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var tagName: String = ""
    @objc dynamic var itemName: String = ""
    @objc dynamic var buyPrice: Double = 0.0
    @objc dynamic var sellPrice: Double = 0.0
    @objc dynamic var buyCount: Double = 0.0
    @objc dynamic var sellCount: Double = 0.0
    @objc dynamic var buyDate: Date = Date(timeIntervalSince1970: 0)
    @objc dynamic var sellDate: Date = Date(timeIntervalSince1970: 0)
    @objc dynamic var memo: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
    convenience init(tagName: String, itemName: String, buyPrice: Double, sellPrice: Double, buyCount: Double, sellCount: Double, buyDate: Date, sellDate: Date, memo: String) {
        self.init()
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
