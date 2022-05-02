//
//  BarView.swift
//  Toolinder
//
//  Created by 송영모 on 2022/04/28.
//

import UIKit
import Then

class BarView: UIView {
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
        addSubview(contentView)
        
        contentBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        if chart.value == 0.0 {
            contentView.backgroundColor = Const.Color.systemGray6
            chart.value = 0.1
            maxValue = 1
        }
        contentView.backgroundColor = chart.color

        
        NSLayoutConstraint.activate([
            contentBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            contentBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentBackgroundView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentBackgroundView.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: contentBackgroundView.heightAnchor, multiplier: chart.value / maxValue)
        ])
    }
}
