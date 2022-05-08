//
//  ListVC+Ext.swift
//  Toolinder
//
//  Created by 송영모 on 2022/04/25.
//
import UIKit
import RxSwift
import RxCocoa
import Then

extension ListViewController {
    func setView() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(chartLabel)
        scrollView.addSubview(pieChartView)
        scrollView.addSubview(tradeCountLabel)
        scrollView.addSubview(sortButton)
        scrollView.addSubview(listTableView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        chartLabel.translatesAutoresizingMaskIntoConstraints = false
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        tradeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        
        listTableViewHeightConstraint = listTableView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            scrollView.widthAnchor.constraint(equalToConstant: self.view.bounds.size.width),
            
            chartLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            chartLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            
            pieChartView.topAnchor.constraint(equalTo: chartLabel.bottomAnchor),
            pieChartView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
//            pieChartView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            pieChartView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -30),
            pieChartView.heightAnchor.constraint(equalToConstant: 180),
            
            tradeCountLabel.topAnchor.constraint(equalTo: pieChartView.bottomAnchor, constant: 15),
            tradeCountLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            
            sortButton.topAnchor.constraint(equalTo: tradeCountLabel.bottomAnchor, constant: 10),
            sortButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            
            listTableView.topAnchor.constraint(equalTo: sortButton.bottomAnchor),
            listTableView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            listTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            listTableViewHeightConstraint,
//            listTableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            listTableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            listTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
        
    }
    
    func setBind() {
        listTableView.rx.itemSelected
            .withUnretained(self)
            .bind { owner, indexPath in
                let cell = owner.listTableView.cellForRow(at: indexPath) as! ListTableViewCell
                let writingVC = WritingViewController()
                writingVC.modalPresentationStyle = .formSheet
                writingVC.update(record: cell.listItemModel.record)
                self.present(writingVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.listItemModels
            .bind(to: listTableView.rx.items(cellIdentifier: ListTableViewCell.identifier, cellType: ListTableViewCell.self)) {
                index, listItemModel, cell in
                cell.update(listItemModel: listItemModel)
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
//
//        viewModel.output.records
//            .bind(to: listTableView.rx.items(cellIdentifier: ListTableViewCell.identifier, cellType: ListTableViewCell.self)) {
//                index, record, cell in
//                cell.update(record: record)
//                cell.selectionStyle = .none
//            }
//            .disposed(by: disposeBag)
        
        viewModel.output.holdingAmountChartData
            .withUnretained(self)
            .bind { owner, charData in
                owner.pieChartView.update(items: charData.points, values: charData.values)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.holdingCount
            .withUnretained(self)
            .bind { owner, count in
                owner.chartLabel.text = "보유종목 \(String(count))개"
            }
            .disposed(by: disposeBag)
        
        viewModel.output.tradeHistoryCount
            .withUnretained(self)
            .bind { owner, count in
                owner.tradeCountLabel.text = "투자내역 \(String(count))개"
            }
            .disposed(by: disposeBag)
    }
}
