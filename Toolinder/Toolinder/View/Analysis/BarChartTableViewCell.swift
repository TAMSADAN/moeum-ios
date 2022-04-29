//
//  BarChartTableViewCell.swift
//  Toolinder
//
//  Created by 송영모 on 2022/04/27.
//

import UIKit
import Then

class BarChartTableViewCell: UITableViewCell {
    
    static let identifier = "BarChartTableViewCell"
    
    var topView = UIView()
    
    var barChart = UIView()
    
    var bottomView = UIView()
    
    var value = CGFloat()
    var text = String()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    
    func update(text: String, value: CGFloat) {
        self.text = text
        self.value = value
    }
    
    func setView() {
        addSubview(barChart)
        
        barChart.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            barChart.topAnchor.constraint(equalTo: topAnchor),
            barChart.widthAnchor.constraint(equalToConstant: 10),
            barChart.heightAnchor.constraint(equalToConstant: 30),
            barChart.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

}
