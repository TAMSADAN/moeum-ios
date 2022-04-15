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
    
    var scrollView = UIScrollView()
        .then {
            $0.scrollsToTop = true
            $0.showsVerticalScrollIndicator = false
        }
    
    var stackView = UIStackView()
        .then {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .equalSpacing
            $0.spacing = 15
        }
    
    var itemPieChartLabel = UILabel()
        .then {
            $0.text = "종목별 현재 매수 비율"
            $0.font = Const.Font.headline
        }
    
    var tagPieChartLabel = UILabel()
        .then {
            $0.text = "태그별 누적 매수 비율"
            $0.font = Const.Font.headline
        }
    
    var incomeBarChartLabel = UILabel()
        .then {
            $0.text = "일별 수익"
            $0.font = Const.Font.headline
        }
    
    var itemPieChartView = ItemPieChartView()
    var tagPieChartView = TagPieChartView()
    var incomeBarChartView = IncomeBarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBind()
        setView()
    }
}
