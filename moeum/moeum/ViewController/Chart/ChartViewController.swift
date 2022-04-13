//
//  ChartViewController.swift
//  moeum
//
//  Created by 송영모 on 2022/04/04.
//

import UIKit
import Charts
import Then
import RxSwift

class ChartViewController: UIViewController {
    
    let viewModel = ChartViewModel()
    var disposBag = DisposeBag()
    
    var combinedChartView = CombinedChartView()
    var barChartView = BarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setView()
        setBind()
    }
}
