//
//  AnalysisViewController.swift
//  Toolinder
//
//  Created by 송영모 on 2022/04/27.
//

import UIKit
import RxSwift
import RxCocoa
import Then

class AnalysisViewController: UIViewController {
    let viewModel = AnalysisViewModel()
    let disposeBag = DisposeBag()
    
    var tradeBarChartView = TradeBarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setBind()
    }
}

extension AnalysisViewController {
    func setView() {
        view.addSubview(tradeBarChartView)
        
        tradeBarChartView.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            tradeBarChartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tradeBarChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tradeBarChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tradeBarChartView.heightAnchor.constraint(equalToConstant: 250),
        ])
    }
}

extension AnalysisViewController {
    func setBind() {
        tradeBarChartView.typeSegmentControl
            .rx
            .selectedSegmentIndex
            .bind(to: viewModel.input.tradeBarChartViewTypeOption)
            .disposed(by: disposeBag)
        
        tradeBarChartView.periodSegmentControl
            .rx
            .selectedSegmentIndex
            .bind(to: viewModel.input.tradeBarChartViewPeriodOption)
            .disposed(by: disposeBag)
        
        viewModel.output.tradeChartZip
            .withUnretained(self)
            .bind { owner, tradeChartZip in
                owner.tradeBarChartView.setTradeChartZip(tradeChartZip: tradeChartZip)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.tradeBarChartViewTypeOption
            .withUnretained(self)
            .bind { owner, option in
                owner.tradeBarChartView.setTypeOption(option: option)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.tradeBarChartViewPeriodOption
            .withUnretained(self)
            .bind { owner, option in
                owner.tradeBarChartView.setPeriodOption(option: option)
            }
            .disposed(by: disposeBag)
    }
}
