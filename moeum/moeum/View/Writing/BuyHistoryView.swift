//
//  HistoryView.swift
//  moeum
//
//  Created by 송영모 on 2022/04/12.
//

import UIKit
import Then

class BuyHistoryView: UIView {
    var scrollView = UIView()
        .then {
            $0.backgroundColor = .systemGray5
        }
    
    var historyStackView = UIStackView()
        .then {
            $0.axis = .vertical
            $0.spacing = 5
            $0.sizeToFit()
        }
    
    var recordZips: [RecordZip] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
    }
    
    func update(recordZips: [RecordZip]) {
        self.recordZips = recordZips
        
        historyStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for recordZip in self.recordZips {
            let historyLabel = BuyHistoryLabel()
            historyLabel.update(recordZip: recordZip)
            
            historyStackView.addArrangedSubview(historyLabel)
            
        }
        
        UIView.performWithoutAnimation {
            historyStackView.setNeedsLayout()
            historyStackView.layoutIfNeeded()
        }
    }
    
    func setView() {
        addSubview(scrollView)
        scrollView.addSubview(historyStackView)
        
        addSubview(historyStackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        historyStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            historyStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            historyStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            historyStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            historyStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
//            historyStackView.topAnchor.constraint(equalTo: topAnchor),
//            historyStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            historyStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            historyStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
