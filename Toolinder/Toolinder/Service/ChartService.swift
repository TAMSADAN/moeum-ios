//
//  ChartService.swift
//  Toolinder
//
//  Created by 송영모 on 2022/05/01.
//

import Foundation

class ChartService {
    let recordService = RecordService()
    
    func getTradeChartZips(period: Period) -> [TradeChartZip] {
        var recordZips: [RecordZip] = []
        var tradeCharZips: [TradeChartZip] = []
        
        var dates: [Date] = []
        var date: Date = Date()
        for _ in 0...6 {
            dates.append(date)
            date = date.plusPeriod(period, interval: -1)
        }
        dates = dates.reversed()
        for date in dates {
            tradeCharZips.append(TradeChartZip(tradeCharts: [TradeChart(buyChart: Chart(), sellChart: Chart())], label: date.getStringPeriod(period: period)))
        }
        
        if period == Period.day {
            recordZips = recordService.getRecordZips(Unit.day)
        } else if period == Period.week {
            recordZips = recordService.getRecordZips(Unit.week)
        } else if period == Period.month {
            recordZips = recordService.getRecordZips(Unit.month)
        } else if period == Period.year {
            recordZips = recordService.getRecordZips(Unit.year)
        }
        
        for recordZip in recordZips {
            let buyRecords: [Record] = recordZip.records.filter({ $0.type == "매수" })
            let sellRecords: [Record] = recordZip.records.filter({ $0.type == "매도" })
            
            let buySumPrice = buyRecords.map { $0.price * $0.count }.reduce(0, +)
            let sellSumPrice = sellRecords.map { $0.price * $0.count }.reduce(0, +)
            
            let tradeChart = TradeChart(buyChart: Chart(value: buySumPrice, color: Const.Color.pink), sellChart: Chart(value: sellSumPrice, color: Const.Color.mint))
            for (i, date) in dates.enumerated() {
                if date.isEqualPeriod(period, date: recordZip.record.date) {
                    tradeCharZips[i].tradeCharts = [tradeChart]
                }
            }
        }
        return tradeCharZips
    }
}
