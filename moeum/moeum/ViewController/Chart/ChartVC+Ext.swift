//
//  ChartVC+Bind.swift
//  moeum
//
//  Created by 송영모 on 2022/04/13.
//

import UIKit
import RxSwift
import RxCocoa

extension ChartViewController {
    func setView() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(itemPieChartLabel)
        stackView.addArrangedSubview(itemPieChartView)
        stackView.addArrangedSubview(tagPieChartLabel)
        stackView.addArrangedSubview(tagPieChartView)
        stackView.addArrangedSubview(incomeBarChartLabel)
        stackView.addArrangedSubview(incomeBarChartView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        itemPieChartLabel.translatesAutoresizingMaskIntoConstraints = false
        itemPieChartView.translatesAutoresizingMaskIntoConstraints = false
        tagPieChartLabel.translatesAutoresizingMaskIntoConstraints = false
        tagPieChartView.translatesAutoresizingMaskIntoConstraints = false
        incomeBarChartLabel.translatesAutoresizingMaskIntoConstraints = false
        incomeBarChartView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20),
            
            itemPieChartView.heightAnchor.constraint(equalToConstant: 200),

            tagPieChartView.heightAnchor.constraint(equalToConstant: 200),
            
            incomeBarChartView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    func setBind() {
        viewModel.output.incomeChartData
            .withUnretained(self)
            .bind { owner, data in
                owner.incomeBarChartView.update(dates: data.0, values: data.1)
            }
            .disposed(by: disposBag)
        
        viewModel.output.priceSumChartData
            .withUnretained(self)
            .bind { owner, data in
                owner.itemPieChartView.update(items: data.0, values: data.1)
            }
            .disposed(by: disposBag)
        
        viewModel.output.tagBuyPriceSumData
            .withUnretained(self)
            .bind { owner, data in
                owner.tagPieChartView.update(items: data.0, values: data.1)
            }
            .disposed(by: disposBag)
    }
}
