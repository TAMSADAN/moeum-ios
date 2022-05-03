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

// Record Zip은 Record를 모아서 분석하는 모델입니다.
struct RecordZip {
    var unit: Unit = Unit.item
    var record: Record = Record()
    
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
    
    func getBuyPriceData(date: Date) -> (Double, Double) {
        let records = records.filter({ $0.date < date })
        
        var buyPriceAvg = 0.0
        var buyCount = 0.0
        
        for record in records {
            if record.type == "매수" {
                buyPriceAvg = (buyPriceAvg * buyCount + record.price * record.count) / (buyCount + record.count)
                buyCount += record.count
            } else if record.type == "매도" {
                buyCount -= record.count
            }
        }
        
        return (buyPriceAvg, buyCount)
    }
    
    private func getSumPrice(date: Date, type: String) -> Double {
        let records = records.filter({ $0.date < date && $0.type == type})
        var sumPrice = 0.0
        
        for record in records {
            sumPrice += record.price * record.count
        }
        
        return sumPrice
    }
    
    func getPriceAvg(date: Date) -> Double {
        return getPriceSum(date: date) / getCountSum(date: date)
    }
    
    func getPriceSum(date: Date) -> Double {
        let records = records.filter({ $0.date < date })
        var priceSum = 0.0
        
        for record in records {
            if record.type == "매수" {
                priceSum += record.price * record.count
            } else if record.type == "매도" {
                priceSum -= record.price * record.count
            }
        }
        return priceSum
    }
    
    func getCountSum(date: Date) -> Double {
        let records = records.filter({ $0.date < date })
//        print("getCountSum", records)
        var countSum = 0.0
        
        for record in records {
            if record.type == "매수" {
                countSum += record.count
            } else if record.type == "매도" {
                countSum -= record.count
            }
        }
        return countSum
    }
}

struct ChartData {
    var points: [String] = []
    var values: [Double] = []
}
