//
//  ChartVC+View.swift
//  moeum
//
//  Created by 송영모 on 2022/04/13.
//

import UIKit
import Charts

extension ChartViewController {
    func setView() {
//        view.addSubview(combinedChartView)
        view.addSubview(barChartView)
        
        barChartView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            barChartView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            barChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            barChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            barChartView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    func setChart(dataPoints: [Date], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        var days:[String] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
            days.append(String(i + 1))
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "판매량")

        chartDataSet.colors = [.systemBlue, .systemRed]
        chartDataSet.highlightEnabled = false

        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        barChartView.doubleTapToZoomEnabled = false
        barChartView.xAxis.granularity = 1
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: days)
        barChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.drawGridLinesEnabled = false
        barChartView.legend.enabled = false
    }
}
