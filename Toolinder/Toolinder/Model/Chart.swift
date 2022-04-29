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
    var TradeCharts: [TradeChart]
}

struct TradeChart {
    var buyChart: Chart
    var sellChart: Chart
}

struct Chart {
    var label: String = ""
    var value: Double = 0.0
    var color: UIColor = Const.Color.orange
    var valueOrigin: Double = 0.0
}
