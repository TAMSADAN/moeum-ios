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

struct RecordChartData {
    var item: String = String()
    var date: Date = Date()
    var income: Double = Double()
    var rate: Double = Double()
}

struct RecordZip {
    var item: String = ""
    var records: [Record] = []
    
    mutating func addRecord(record: Record) {
        records.append(record)
    }
    
    func getRecordChartDatas() -> [RecordChartData] {
        let records = records.filter({ $0.type == "매도" })
        var recordChartDatas: [RecordChartData] = []
        
        for record in records {
            recordChartDatas.append(getRecordChartData(record: record))
        }
        
        return recordChartDatas
    }
    
    func getRecordChartData(record: Record) -> RecordChartData {
        var recordChartData = RecordChartData()
        let nowPriceAvg = getPriceAvg(date: record.date)
        
        recordChartData.item = record.item
        recordChartData.date = record.date
        recordChartData.income = (record.price - nowPriceAvg) * record.count
        recordChartData.rate = (record.price - nowPriceAvg) / nowPriceAvg * 100
        
        if recordChartData.income.isNaN {
            recordChartData.income = 0.0
        }
        
        if recordChartData.rate.isNaN {
            recordChartData.rate = 0.0
        }
        
        return recordChartData
    }
    
    func getPriceAvg(date: Date) -> Double {
        return getPriceSum(date: date) / getCountSum(date: date)
    }
    
    func getPriceSum(date: Date) -> Double {
        let records = records.filter({ $0.date < date})
        var priceSum = 0.0
        
        for record in records {
            if record.type == "매수" {
                priceSum += record.price * record.count
            } else {
                priceSum -= record.price * record.count
            }
        }
        return priceSum
    }
    
    func getCountSum(date: Date) -> Double {
        let records = records.filter({ $0.date < date })
        var countSum = 0.0
        
        for record in records {
            if record.type == "매수" {
                countSum += record.count
            } else {
                countSum -= record.count
            }
        }
        return countSum
    }
}
