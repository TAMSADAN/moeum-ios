//
//  IncomeBarChartView.swift
//  moeum
//
//  Created by 송영모 on 2022/04/15.
//

import UIKit
import Then
import Charts

class IncomeBarChartView: UIView {
    var barChartView = BarChartView()
    
    var dates: [Date] = []
    var values: [Double] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    func update(dates: [Date], values: [Double]) {
        self.dates = dates
        self.values = values
        setChart(dataPoints: self.dates, values: self.values)
    }
    
    func setChart(dataPoints: [Date], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        var days:[String] = []
        var colors: [UIColor] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
            
            days.append(String(i + 1))
            if values[i] >= 0 {
                colors.append(.systemRed)
            } else {
                colors.append(.systemBlue)
            }
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "판매량")
            .then {
                $0.colors = colors
                $0.highlightEnabled = false
                $0.drawValuesEnabled = false
            }
        
        let chartData = BarChartData(dataSet: chartDataSet)
        
        barChartView
            .then {
                $0.data = chartData
                $0.doubleTapToZoomEnabled = false
                $0.highlightPerTapEnabled = false
                $0.xAxis.granularity = 1
                $0.xAxis.labelFont = Const.Font.caption5
                $0.xAxis.setLabelCount(dataPoints.count, force: true)
                $0.xAxis.valueFormatter = IndexAxisValueFormatter(values: days)
                $0.xAxis.labelPosition = XAxis.LabelPosition.bottom
                $0.xAxis.forceLabelsEnabled = false
                $0.xAxis.drawGridLinesEnabled = false
                $0.leftAxis.drawGridLinesEnabled = false
                $0.rightAxis.drawGridLinesEnabled = false
                $0.rightAxis.drawLabelsEnabled = false
                $0.legend.enabled = false
                $0.drawBordersEnabled = false
            }
    }
    
    func setView() {
        addSubview(barChartView)
        
        barChartView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            barChartView.topAnchor.constraint(equalTo: topAnchor),
            barChartView.leadingAnchor.constraint(equalTo: leadingAnchor),
            barChartView.trailingAnchor.constraint(equalTo: trailingAnchor),
            barChartView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }


}
