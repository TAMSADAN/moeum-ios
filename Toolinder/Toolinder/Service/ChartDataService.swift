//
//  ChartService.swift
//  Toolinder
//
//  Created by 송영모 on 2022/04/25.
//

import Foundation

class ChartDataService {
    func getHoldingAmountChartData(date: Date, recordZips: [RecordZip]) -> ChartData {
        var points: [String] = []
        var datas: [Double] = []
        
        for recordZip in recordZips {
            let point = recordZip.item
            let (buyPriceAvg, buyCount) = recordZip.getBuyPriceData(date: date)
            
            points.append(point)
            datas.append(buyPriceAvg * buyCount)
        }
        return ChartData(points: points, values: datas)
    }
}
