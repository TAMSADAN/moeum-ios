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
    @objc dynamic var tag: String = ""
    @objc dynamic var item: String = ""
    @objc dynamic var price: Double = 0.0
    @objc dynamic var count: Double = 0.0
    @objc dynamic var date: Date = Date()
    @objc dynamic var memo: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
    convenience init(id: Int = 0, tag: String, item: String, price: Double, count: Double, date: Date, memo: String) {
        self.init()
        self.id = id
        self.tag = tag
        self.item = item
        self.price = price
        self.count = count
        self.date = date
        self.memo = memo
    }
}
