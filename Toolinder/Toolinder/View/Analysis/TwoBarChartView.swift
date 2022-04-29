//
//  TwoBarChartView.swift
//  Toolinder
//
//  Created by 송영모 on 2022/04/29.
//

import UIKit

class TwoBarChartView: UIScrollView, UIScrollViewDelegate {
    
    var buyBarViews: [BarView] = []
    var sellBarViews: [BarView] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
        refresh()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        refresh()
    }
    
    func update(buyChartZip: ChartZip, sellChartZip: ChartZip) {
        refresh()
        let last = buyChartZip.charts.count > sellChartZip.charts.count ? sellChartZip.charts.count : buyChartZip.charts.count
        
        for i in 0..<last {
            buyBarViews.append(BarView(chart: buyChartZip.charts[i]))
            sellBarViews.append(BarView(chart: sellChartZip.charts[i]))
        }
        
        for i in 0..<last {
            addSubview(buyBarViews[i])
            addSubview(sellBarViews[i])
            
            buyBarViews[i].translatesAutoresizingMaskIntoConstraints = false
            sellBarViews[i].translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                buyBarViews[i].heightAnchor.constraint(equalTo: heightAnchor),
                buyBarViews[i].widthAnchor.constraint(equalToConstant: 100),
                
                sellBarViews[i].leadingAnchor.constraint(equalTo: buyBarViews[i].trailingAnchor),
                sellBarViews[i].widthAnchor.constraint(equalTo: buyBarViews[i].widthAnchor),
                sellBarViews[i].heightAnchor.constraint(equalTo: heightAnchor)
            ])
            
            if i == 0 {
                NSLayoutConstraint.activate([
                    buyBarViews[i].leadingAnchor.constraint(equalTo: leadingAnchor),
                ])
            } else if i == last - 1 {
                NSLayoutConstraint.activate([
                    buyBarViews[i].leadingAnchor.constraint(equalTo: sellBarViews[i-1].trailingAnchor),
                    sellBarViews[i].trailingAnchor.constraint(equalTo: trailingAnchor),
                ])
            } else {
                NSLayoutConstraint.activate([
                    buyBarViews[i].leadingAnchor.constraint(equalTo: sellBarViews[i-1].trailingAnchor),
                ])
            }
            
        }
    }
    
    func refresh() {
        for view in buyBarViews {
            view.removeFromSuperview()
        }
        
        for view in sellBarViews {
            view.removeFromSuperview()
        }
    }
    
    func setView() {
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        delegate = self
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.isDragging == false {
            let prevX = scrollView.contentOffset.x
            let nextX = ceil(prevX / 100) * 100
            print(nextX)
    
            scrollView.setContentOffset(CGPoint(x: nextX, y: 0), animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.isDragging == false {
            let prevX = scrollView.contentOffset.x
            let nextX = ceil(prevX / 100) * 100
    
            scrollView.setContentOffset(CGPoint(x: nextX, y: 0), animated: true)
        }
    }
}
