//
//  ChartViewController.swift
//  moeum
//
//  Created by 송영모 on 2022/04/04.
//

import UIKit
import Charts
import Then

class ChartViewController: UIViewController {

    var combinedChartView = CombinedChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setView()
    }
    
    func setChart() {
        var y: [ChartDataEntry] = [ChartDataEntry]
    }
    
    func setView() {
        view.addSubview(combinedChartView)
        
        combinedChartView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            combinedChartView.topAnchor.constraint(equalTo: view.topAnchor),
            combinedChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            combinedChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            combinedChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
