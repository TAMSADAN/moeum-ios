//
//  RecordZip.swift
//  Toolinder
//
//  Created by 송영모 on 2022/05/06.
//

import Foundation

struct RecordZip {
    var unit: Unit = Unit.item
    var record: Record = Record()
    
    var records: [Record] = []
    
    mutating func addRecord(record: Record) {
        records.append(record)
    }
    
    func getProfitPriceSum() -> Double {
        var records = records.sorted(by: { $0.date < $1.date})
        records = records.filter({ $0.type == "매도" })
        
        var profitPriceSum = 0.0
        for record in records {
            profitPriceSum += getProfitPriceAt(record: record)
        }
        
        return profitPriceSum
    }
    
    func getProfitPriceAt(record: Record) -> Double {
        let (buyAvgPrice, _) = getBuyDataAt(record: record)
        
        return (record.price - buyAvgPrice) * record.count
    }
    
    func getBuyDataAt(record: Record) -> (Double, Double) {
        var records = records.filter({ $0.date <= record.date })
        records.sort(by: { $0.date < $1.date })
        
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

    func getPriceSum(type: String? = nil, date: Date = Date(), isInclude: Bool = false) -> Double {
        var priceSum = 0.0
        var records: [Record] = []
        
        if isInclude {
            records = self.records.filter({ $0.date <= date })
        } else {
            records = self.records.filter({ $0.date < date })
        }
        
        if type == nil {
            records.forEach({
                if $0.type == "매수" {
                    priceSum += $0.price * $0.count
                } else if $0.type == "매도" {
                    priceSum -= $0.price * $0.count
                }
            })
            return priceSum
        } else {
            records.filter({ $0.type == type}).forEach({
                priceSum += $0.price * $0.count
            })
            return priceSum
        }
    }
    
    func getCountSum(type: String? = nil, date: Date = Date(), isInclude: Bool = false) -> Double {
        var countSum = 0.0
        var records: [Record] = []
        
        if isInclude {
            records = self.records.filter({ $0.date <= date })
        } else {
            records = self.records.filter({ $0.date < date })
        }
        
        if type == nil {
            records.forEach({
                if $0.type == "매수" {
                    countSum += $0.count
                } else if $0.type == "매도" {
                    countSum -= $0.count
                }
            })
            return countSum
        } else {
            records.filter({ $0.type == type}).forEach({
                countSum += $0.count
            })
            return countSum
        }
    }
}
