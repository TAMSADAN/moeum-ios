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
        $0.text = "탑"
        $0.font = Const.Font.footnote
        $0.textColor = Const.Color.black
        $0.textAlignment = .center
    }
    
    var bottomLabel = UILabel().then {
        $0.text = "바텀"
        $0.font = Const.Font.footnote
        $0.textColor = Const.Color.black
        $0.textAlignment = .center
    }
    
    var buyBarView: BarView!
    var sellBarView: BarView!
    
    var buyBarViewWidthConstraint = NSLayoutConstraint()
    var sellBarViewWidthConstraint = NSLayoutConstraint()
    var barContainer = UILayoutGuide()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(tradeChart: TradeChart) {
        super.init(frame: .zero)
        buyBarView = BarView(chart: tradeChart.buyChart)
        sellBarView = BarView(chart: tradeChart.sellChart)
        setView()
    }
    
    func setView() {
        addLayoutGuide(barContainer)
        addSubview(topLabel)
        addSubview(buyBarView)
        addSubview(sellBarView)
        addSubview(bottomLabel)
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        buyBarView.translatesAutoresizingMaskIntoConstraints = false
        sellBarView.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        
        buyBarViewWidthConstraint = buyBarView.widthAnchor.constraint(equalTo: barContainer.widthAnchor, multiplier: 0.45)
        sellBarViewWidthConstraint = sellBarView.widthAnchor.constraint(equalTo: barContainer.widthAnchor, multiplier: 0.45)
        
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: topAnchor),
            topLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            topLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            topLabel.heightAnchor.constraint(equalToConstant: 30),
            
            barContainer.topAnchor.constraint(equalTo: topLabel.bottomAnchor),
            barContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            barContainer.bottomAnchor.constraint(equalTo: bottomLabel.topAnchor),
            barContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            
            buyBarView.topAnchor.constraint(equalTo: barContainer.topAnchor),
            buyBarView.leadingAnchor.constraint(equalTo: barContainer.leadingAnchor),
            buyBarView.bottomAnchor.constraint(equalTo: barContainer.bottomAnchor),
            buyBarViewWidthConstraint,
            
            sellBarView.topAnchor.constraint(equalTo: barContainer.topAnchor),
            sellBarView.trailingAnchor.constraint(equalTo: barContainer.trailingAnchor, constant: 2),
            sellBarView.bottomAnchor.constraint(equalTo: barContainer.bottomAnchor),
            sellBarViewWidthConstraint,
            
            bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}

extension TradeBarView {
    func showAllBarView() {
        buyBarViewWidthConstraint.constant = 0
        sellBarViewWidthConstraint.constant = 0
        
        UIView.animate(withDuration: 0.25, animations: {
            self.buyBarViewWidthConstraint.isActive = true
            self.sellBarViewWidthConstraint.isActive = true
            self.layoutIfNeeded()
        })
    }
    
    func showBuyBarView() {
        buyBarViewWidthConstraint.constant = barContainer.layoutFrame.width * 0.45
        sellBarViewWidthConstraint.constant = -1 * barContainer.layoutFrame.width * 0.45
        UIView.animate(withDuration: 0.25, animations: {
            self.buyBarViewWidthConstraint.isActive = true
            self.sellBarViewWidthConstraint.isActive = true
            self.layoutIfNeeded()
        })
    }
    
    func showSellBarView() {
        buyBarViewWidthConstraint.constant = -1 * barContainer.layoutFrame.width * 0.45
        sellBarViewWidthConstraint.constant = barContainer.layoutFrame.width * 0.45
        UIView.animate(withDuration: 0.25, animations: {
            self.buyBarViewWidthConstraint.isActive = true
            self.sellBarViewWidthConstraint.isActive = true
            self.layoutIfNeeded()
        })
    }
}
