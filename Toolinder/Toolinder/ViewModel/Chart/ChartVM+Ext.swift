//
//  ChartVM+Ext.swift
//  moeum
//
//  Created by 송영모 on 2022/04/14.
//

import Foundation

extension ChartViewModel {
    func setBind() {
        input.recordZips.onNext(recordService.getRecordZipsISOLDCODE(tag: true, item: true))
        input.tagRecordZips.onNext(recordService.getRecordZipsISOLDCODE(tag: true, item: false))
        input.itemRecordZips.onNext(recordService.getRecordZipsISOLDCODE(tag: false, item: true))
        
        input.itemRecordZips
            .bind { [weak self] recordZips in
                self?.output.incomeChartData.accept(self?.getIncomeBarChartData(date: Date(), recordZips: recordZips) ?? ([Date()], [Double()]))
                self?.output.priceSumChartData.accept(self?.getBuyPriceSumPieChartData(date: Date(), recordZips: recordZips) ?? ([String()], [Double()]))
            }
            .disposed(by: disposeBag)
        
        input.tagRecordZips
            .withUnretained(self)
            .bind { owner, tagRecordZips in
                owner.output.tagBuyPriceSumData.accept(owner.getTagBuyPriceTotalChartData(recordZips: tagRecordZips))
            }
            .disposed(by: disposeBag)
    }
    
    func getBuyPriceSumPieChartData(date: Date, recordZips: [RecordZip]) -> ([String], [Double]) {
        var items: [String] = []
        var priceSums: [Double] = []
        
        for recordZip in recordZips {
            let item = recordZip.record.item
            let (buyPriceAvg, buyCount) = recordZip.getBuyPriceData(date: date)
            
            items.append(item)
            priceSums.append(buyPriceAvg * buyCount)
        }
        print(items, priceSums)
        return (items, priceSums)
    }
    
    func getTagBuyPriceTotalChartData(recordZips: [RecordZip]) -> ([String], [Double]) {
        var tags: [String] = []
        var buyPriceSums: [Double] = []
        
        for recordZip in recordZips {
            let tag = recordZip.record.tag
            var buyPriceSum = 0.0
            
            for record in recordZip.records.filter({ $0.type == "매수" }) {
                buyPriceSum += record.price * record.count
            }
            tags.append(tag)
            buyPriceSums.append(buyPriceSum)
        }
        
        return (tags, buyPriceSums)
    }
    
    
    func getIncomeBarChartData(date: Date, recordZips: [RecordZip]) -> ([Date], [Double]) {
        let dates = date.getDatesOfMonth()
        var incomes:[Double] = []
        var incomeDatas: [(Date, Double)] = []
        
        for recordZip in recordZips {
            for record in recordZip.records.filter({ $0.type == "매도" }) {
                let recordDate = record.date
                let (buyPriceAvg, _) = recordZip.getBuyPriceData(date: record.date)
                
                var recordIncome = (record.price - buyPriceAvg) * record.count
                if recordIncome.isNaN {
                    recordIncome = 0.0
                }
                incomeDatas.append((recordDate, recordIncome))
            }
        }
        
        for date in dates {
            var income = 0.0
            for incomeData in incomeDatas {
                if date.isEqualDate(date: incomeData.0) {
                    income += incomeData.1
                }
            }
            incomes.append(income)
        }
        
        return (dates, incomes)
    }
}
