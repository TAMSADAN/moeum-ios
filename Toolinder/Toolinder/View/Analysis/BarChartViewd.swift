////
////  BarChartView.swift
////  Toolinder
////
////  Created by 송영모 on 2022/04/28.
////
//
//import UIKit
//import Then
//
//class BarChartView: UIView {
//    
//    var barViews: [OneBarView] = []
////    var barView = BarView(text: "0", value: 0.2, color: Const.Color.mint)
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setView()
//    }
//    
//    init() {
//        super.init(frame: .zero)
//        setView()
//    }
//    
//    func update(chartZip: ChartZip) {
//        for chart in chartZip.charts {
//            barViews.append(OneBarView(chart: chart, color: Const.Color.cyan))
//        }
//        
//        for i in 0..<barViews.count {
//            addSubview(barViews[i])
//            
//            barViews[i].translatesAutoresizingMaskIntoConstraints = false
//            
//            NSLayoutConstraint.activate([
//                barViews[i].topAnchor.constraint(equalTo: topAnchor),
//                barViews[i].bottomAnchor.constraint(equalTo: bottomAnchor),
//                barViews[i].widthAnchor.constraint(equalTo: widthAnchor, multiplier: CGFloat(Float(1) / Float(barViews.count))),
//            ])
//            
//            if i == 0 {
//                NSLayoutConstraint.activate([
//                    barViews[i].leadingAnchor.constraint(equalTo: leadingAnchor),
//                ])
//            } else {
//                NSLayoutConstraint.activate([
//                    barViews[i].leadingAnchor.constraint(equalTo: barViews[i-1].trailingAnchor),
//                ])
//            }
//            
////            NSLayoutConstraint.activate([
////                barViews[i].topAnchor.constraint(equalTo: topAnchor),
////                barViews[i].
////            ])
//        }
//    }
//    
//    func setView() {
////        addSubview(barView)
////
////        barView.translatesAutoresizingMaskIntoConstraints = false
////
////        NSLayoutConstraint.activate([
////            barView.topAnchor.constraint(equalTo: topAnchor),
////            barView.leadingAnchor.constraint(equalTo: leadingAnchor),
////            barView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
////            barView.bottomAnchor.constraint(equalTo: bottomAnchor),
////        ])
//    }
//}
