//
//  Chart.swift
//  Toolinder
//
//  Created by 송영모 on 2022/04/28.
//

import Foundation
import UIKit

struct ChartZip {
    var charts: [Chart]
}

struct TradeChartZip {
    var tradeCharts: [TradeChart] = []
    var label: String = ""
    
    func getMaxValue() -> Double {
        return max(self.tradeCharts.map { $0.buyChart.value }.max() ?? 0.0, self.tradeCharts.map { $0.sellChart.value }.max() ?? 0.0)
    }
}

struct TradeChart {
    var buyChart: Chart
    var sellChart: Chart
}

struct Chart {
    var value: Double = 0.0
    var color: UIColor = Const.Color.orange
}
