//
//  BarChartCollectionViewCell.swift
//  Toolinder
//
//  Created by 송영모 on 2022/04/28.
//

import UIKit
import Then

class BarChartCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BarChartCollectionViewCell"
    
    var barChart = UIView()
        .then {
            $0.backgroundColor = Const.Color.mint
        }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
    }
    
    func setView() {
        addSubview(barChart)
        
        barChart.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            barChart.topAnchor.constraint(equalTo: topAnchor),
            barChart.leadingAnchor.constraint(equalTo: leadingAnchor),
            barChart.bottomAnchor.constraint(equalTo: bottomAnchor),
            barChart.widthAnchor.constraint(equalToConstant: 400),
            barChart.heightAnchor.constraint(equalToConstant: 400),
        ])
    }
}
