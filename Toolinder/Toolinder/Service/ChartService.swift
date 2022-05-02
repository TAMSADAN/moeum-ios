//
//  ChartService.swift
//  Toolinder
//
//  Created by 송영모 on 2022/05/01.
//

import Foundation

class ChartService {
    let recordService = RecordService()
    
    //    struct TradeChartZip {
    //        var TradeCharts: [TradeChart]
    //        var label: String = ""
    //    }
    //
    //    struct TradeChart {
    //        var buyChart: Chart
    //        var sellChart: Chart
    //    }
    //
    //    struct Chart {
    //        var value: Double = 0.0
    //        var color: UIColor = Const.Color.orange
    //        var valueOrigin: Double = 0.0
    //    }
    
    func getTradeChartZips(period: Period) -> [TradeChartZip] {
        var recordZips: [RecordZip] = []
        var tradeCharts: [TradeChart] = []
        var tradeCharZips: [TradeChartZip] = []
        
        var dates: [Date] = []
        var date: Date = Date()
        for _ in 0...6 {
            dates.append(date)
            date = date.plusPeriod(-1, period: period)
        }
        dates = dates.reversed()
        for date in dates {
            tradeCharZips.append(TradeChartZip(tradeCharts: [], label: date.getStringPeriod(period: period)))
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
            
            tradeCharts.append(tradeChart)
            for (i, date) in dates.enumerated() {
                if date.isEqualPeriod(recordZip.record.date, period: period) {
                    tradeCharZips[i].tradeCharts = tradeCharts
                }
            }
        }
        
        return tradeCharZips
    }
    
    
    func parseToChart(record: Record) -> Chart? {
        if record.type == "매수" {
            return Chart(value: record.price, color: Const.Color.pink)
        } else if record.type == "매도" {
            return Chart(value: record.price, color: Const.Color.mint)
        } else {
            return nil
        }
    }
}
