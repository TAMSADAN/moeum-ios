//
//  ChartViewController.swift
//  moeum
//
//  Created by 송영모 on 2022/04/04.
//

import UIKit
import Charts
import RxSwift
import Then

class ChartViewController: UIViewController {
    
    let viewModel = ChartViewModel()
    var disposBag = DisposeBag()
    
    var combinedChartView = CombinedChartView()
    var pieChartLabel = UILabel()
        .then {
            $0.text = "종목별 매수 그래프"
            $0.font = Const.Font.title3
        }
    
    var barChartLabel = UILabel()
        .then {
            $0.text = "월 수익 그래프"
            $0.font = Const.Font.title3
        }
    
    var barChartView = BarChartView()
    var pieChartView = PieChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setView()
        setBind()
        setPieChartView(dataPoints: ["1","2", "3"], values: [30, 30, 40])
    }
}
