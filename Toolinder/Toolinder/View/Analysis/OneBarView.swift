////
////  BarView.swift
////  Toolinder
////
////  Created by 송영모 on 2022/04/28.
////
//
//import UIKit
//import Then
//
//class OneBarView: UIView {
//    
//    var label = String()
//    var value = CGFloat()
//    var color = UIColor()
//    var chart: Chart!
//    
//    var barBackgroundView = UIView()
//    
//    var barTopView = UIView()
////        .then {
////            $0.backgroundColor = Const.Color.indigo
////        }
//    
//    var barView = UIView().then {
//        $0.backgroundColor = Const.Color.mint
//        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//    }
//    
//    var barBottomLabel = UILabel().then {
//        $0.font = Const.Font.itemBody
//        $0.textColor = .black
//        $0.textAlignment = .center
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setView()
//    }
//    
//    init(chart: Chart, color: UIColor) {
//        super.init(frame: .zero)
//        
//        self.chart = chart
//        self.color = color
//        
//        setView()
//    }
//    
//    func setView() {
//        addSubview(barBackgroundView)
//        addSubview(barTopView)
//        addSubview(barView)
//        addSubview(barBottomLabel)
//        
//        barBackgroundView.translatesAutoresizingMaskIntoConstraints = false
//        barTopView.translatesAutoresizingMaskIntoConstraints = false
//        barView.translatesAutoresizingMaskIntoConstraints = false
//        barBottomLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        barView.layer.cornerRadius = 10
//        barBottomLabel.text = chart.label
//        
//        NSLayoutConstraint.activate([
//            barBottomLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            barBottomLabel.heightAnchor.constraint(equalToConstant: 20),
//            barBottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
//            
//            barBackgroundView.topAnchor.constraint(equalTo: topAnchor),
//            barBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
//            barBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
//            barBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
//            
//            barTopView.topAnchor.constraint(equalTo: barBackgroundView.topAnchor),
//            barTopView.leadingAnchor.constraint(equalTo: barBackgroundView.leadingAnchor),
//            barTopView.trailingAnchor.constraint(equalTo: barBackgroundView.trailingAnchor),
//            
//            barView.topAnchor.constraint(equalTo: barTopView.bottomAnchor),
//            barView.leadingAnchor.constraint(equalTo: barBackgroundView.leadingAnchor),
//            barView.trailingAnchor.constraint(equalTo: barBackgroundView.trailingAnchor),
//            barView.bottomAnchor.constraint(equalTo: barBackgroundView.bottomAnchor),
//            barView.heightAnchor.constraint(equalTo: barBackgroundView.heightAnchor, multiplier: chart.value),
//        ])
//    }
//}
