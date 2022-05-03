//
//  BarView.swift
//  Toolinder
//
//  Created by 송영모 on 2022/04/28.
//

import UIKit
import Then

class BarView: UIView {
    var topLabel = UILabel().then {
        $0.font = Const.Font.caption4
        $0.textAlignment = .center
    }
    
    var contentBackgroundView = UIView()
    
    var contentView = UIView().then {
        $0.layer.cornerRadius = 5
    }
    
    var chart: Chart!
    var maxValue: Double!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    init(chart: Chart, maxValue: Double) {
        super.init(frame: .zero)
        self.chart = chart
        self.maxValue = maxValue
        setView()
    }
    
    func setView() {
        addSubview(contentBackgroundView)
        addSubview(topLabel)
        addSubview(contentView)
        
        contentBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        if chart.value == 0.0 {
            contentView.backgroundColor = Const.Color.systemGray4
            chart.value = 0.05
            maxValue = 1
        } else {
            contentView.backgroundColor = chart.color
            topLabel.text = String((ceil((chart.value / 10000.0) * Double(10))) / Double(10))
        }
        
        NSLayoutConstraint.activate([
            contentBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            contentBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentBackgroundView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentBackgroundView.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: contentBackgroundView.heightAnchor, multiplier: chart.value / maxValue),
            
            topLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            topLabel.bottomAnchor.constraint(equalTo: contentView.topAnchor),
        ])
    }
}
