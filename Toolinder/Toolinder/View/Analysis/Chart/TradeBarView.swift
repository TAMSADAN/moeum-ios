//
//  TradeBarView.swift
//  Toolinder
//
//  Created by 송영모 on 2022/04/29.
//

import UIKit
import Then

class TradeBarView: UIView {
    var topLabel = UILabel().then {
        $0.font = Const.Font.caption5
        $0.textColor = Const.Color.black
        $0.textAlignment = .center
    }
    var bottomLabelBackgroundView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    var bottomLabel = UILabel().then {
        $0.font = Const.Font.itemFootnote
        $0.textColor = Const.Color.black
        $0.textAlignment = .center
    }
    var barStackView = UIStackView().then {
        $0.alignment = .center
        $0.distribution = .fillEqually
        $0.spacing = 2
    }
    
    var buyBarViews: [BarView] = []
    var sellBarViews: [BarView] = []
    var buyBarViewWidthConstraints: [NSLayoutConstraint] = []
    var sellBarViewWidthConstraints: [NSLayoutConstraint] = []
    
    var tradeChartZip: TradeChartZip!
    var maxValue: Double!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(tradeChartZip: TradeChartZip, maxValue: Double) {
        super.init(frame: .zero)
        self.tradeChartZip = tradeChartZip
        self.maxValue = maxValue
        setView()
    }
    
    func setView() {
        addSubview(topLabel)
        addSubview(barStackView)
        addSubview(bottomLabelBackgroundView)
        addSubview(bottomLabel)
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        barStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomLabelBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bottomLabel.text = tradeChartZip.label
        
        for tradeChart in tradeChartZip.tradeCharts {
            buyBarViews.append(BarView(chart: tradeChart.buyChart, maxValue: maxValue))
            sellBarViews.append(BarView(chart: tradeChart.sellChart, maxValue: maxValue))
        }
        
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: topAnchor),
            topLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            topLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            topLabel.heightAnchor.constraint(equalToConstant: 30),
            
            barStackView.topAnchor.constraint(equalTo: topLabel.bottomAnchor),
            barStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            barStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            
            bottomLabel.topAnchor.constraint(equalTo: barStackView.bottomAnchor, constant: 2),
            bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        for i in 0..<tradeChartZip.tradeCharts.count {
            barStackView.addArrangedSubview(buyBarViews[i])
            barStackView.addArrangedSubview(sellBarViews[i])
            
            buyBarViews[i].translatesAutoresizingMaskIntoConstraints = false
            sellBarViews[i].translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                buyBarViews[i].topAnchor.constraint(equalTo: barStackView.topAnchor),
                buyBarViews[i].bottomAnchor.constraint(equalTo: barStackView.bottomAnchor),
                
                sellBarViews[i].topAnchor.constraint(equalTo: barStackView.topAnchor),
                sellBarViews[i].bottomAnchor.constraint(equalTo: barStackView.bottomAnchor),
            ])
        }
    }
}

extension TradeBarView {
    func showAllBarView() {
        for i in 0..<tradeChartZip.tradeCharts.count {
            buyBarViews[i].isHidden = false
            sellBarViews[i].isHidden = false
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.layoutIfNeeded()
        })
    }
    
    func showBuyBarView() {
        for i in 0..<tradeChartZip.tradeCharts.count {
            buyBarViews[i].isHidden = false
            sellBarViews[i].isHidden = true
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.layoutIfNeeded()
        })
    }
    
    func showSellBarView() {
        for i in 0..<tradeChartZip.tradeCharts.count {
            buyBarViews[i].isHidden = true
            sellBarViews[i].isHidden = false
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.layoutIfNeeded()
        })
    }
}
