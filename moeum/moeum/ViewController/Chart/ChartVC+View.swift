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
        view.addSubview(pieChartLabel)
        view.addSubview(pieChartView)
        view.addSubview(barChartLabel)
        view.addSubview(barChartView)
        
        pieChartLabel.translatesAutoresizingMaskIntoConstraints = false
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        barChartLabel.translatesAutoresizingMaskIntoConstraints = false
        barChartView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pieChartLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            pieChartLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            pieChartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            pieChartView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            pieChartView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            pieChartView.heightAnchor.constraint(equalToConstant: 200),
            
            barChartView.topAnchor.constraint(equalTo: pieChartView.bottomAnchor, constant: 15),
            barChartView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            barChartView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            barChartView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    func setPieChartView(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        pieChartDataSet.colors = [.systemPink, .systemBrown, .systemOrange]
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        pieChartData.setValueFont(Const.Font.caption2)
        pieChartView.data = pieChartData
        
    }
    
    func setBarChartView(dates: [Date], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        var days:[String] = []
        for i in 0..<dates.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
            days.append(String(i + 1))
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "판매량")

        chartDataSet.colors = [.systemBlue, .systemRed]
        chartDataSet.highlightEnabled = false
        chartDataSet.drawValuesEnabled = false
        
        let chartData = BarChartData(dataSet: chartDataSet)
        
        barChartView.data = chartData
        barChartView.doubleTapToZoomEnabled = false
        barChartView.xAxis.granularity = 1
        barChartView.xAxis.labelFont = .systemFont(ofSize: 8)
        barChartView.xAxis.setLabelCount(dates.count, force: true)
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: days)
        barChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        barChartView.xAxis.forceLabelsEnabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.drawLabelsEnabled = false
        barChartView.legend.enabled = false
        barChartView.drawBordersEnabled = false
    }
}
