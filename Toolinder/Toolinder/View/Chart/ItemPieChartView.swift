//
//  ItemPieChartView.swift
//  moeum
//
//  Created by 송영모 on 2022/04/15.
//

import UIKit
import Then
import Charts

class ItemPieChartView: UIView {
    var pieChartView = PieChartView()
    
    var items: [String] = []
    var values: [Double] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    func update(items: [String], values: [Double]) {
        self.items = items
        self.values = values
        setChart(dataPoints: self.items, values: self.values)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        var colors: [UIColor] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: ceil(values[i]), label: dataPoints[i])
            dataEntries.append(dataEntry)
            colors.append(UIColor.random)
        }
        
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: "")
            .then {
                $0.colors = [Const.Color.blue, Const.Color.orange, Const.Color.purple, Const.Color.indigo, Const.Color.green, Const.Color.pink, Const.Color.mint,]
            }
        
        let format = NumberFormatter()
            .then {
                $0.numberStyle = .currency
                $0.roundingMode = .ceiling
            }
        
        let formatter = DefaultValueFormatter(formatter: format)
        
        let chartData = PieChartData(dataSet: chartDataSet)
            .then {
                $0.setValueFormatter(formatter)
                $0.setValueFont(Const.Font.caption5)
                $0.setValueTextColor(.black)
            }
        
        pieChartView
            .then {
                $0.data = chartData
                $0.highlightPerTapEnabled = false
                $0.rotationEnabled = false
            }
    }
    
    func setView() {
        addSubview(pieChartView)
        
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pieChartView.topAnchor.constraint(equalTo: topAnchor),
            pieChartView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pieChartView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pieChartView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
