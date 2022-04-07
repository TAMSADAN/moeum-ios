//
//  WritingVC+UI.swift
//  moeum
//
//  Created by 송영모 on 2022/04/04.
//

import UIKit
import RxSwift
import RxCocoa

extension WritingViewController {
    func setView() {
        view.backgroundColor = .white
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        view.addSubview(writingView)
        writingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            writingView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            writingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            writingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            writingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func bindView() {
        self.writingView.tagTextField.textField.rx.text.orEmpty
            .bind(to: self.viewModel.input.tagName)
            .disposed(by: self.diposeBag)
        
        self.writingView.nameTextField.textField.rx.text.orEmpty
            .bind(to: self.viewModel.input.itemName)
            .disposed(by: self.diposeBag)
        
        self.writingView.buyDateButton.tapGesture.rx.event
            .subscribe(onNext: {
                _ in self.viewModel.clickBuyDateButton()
            })
            .disposed(by: self.diposeBag)
        
        self.writingView.sellDateButton.tapGesture.rx.event
            .subscribe(onNext: {
                _ in self.viewModel.clickSellDateButton()
            })
            .disposed(by: self.diposeBag)
        
        self.writingView.datePicker.rx.date
            .bind(to: viewModel.input.date)
            .disposed(by: self.diposeBag)
        
        self.writingView.buyTextField.textField.rx.text.orEmpty
            .bind(to: self.viewModel.input.buyPrice)
            .disposed(by: self.diposeBag)
        
        self.writingView.sellTextField.textField.rx.text.orEmpty
            .bind(to: self.viewModel.input.sellPrice)
            .disposed(by: self.diposeBag)
        
        self.writingView.buyCountTextField.textField.rx.text.orEmpty
            .bind(to: self.viewModel.input.buyCount)
            .disposed(by: self.diposeBag)
        
        self.writingView.sellCountTextField.textField.rx.text.orEmpty
            .bind(to: self.viewModel.input.sellCount)
            .disposed(by: self.diposeBag)
        
        self.viewModel.output.buyDate
            .withUnretained(self)
            .bind { owner, date in
                if date != Date(timeIntervalSince1970: 0) {
                    owner.writingView.buyDateButton.dateLabel.text = self.viewModel.getDateStringFromDate(date: date)
                    owner.writingView.buyDateButton.timeLabel.text =
                    self.viewModel.getTimeStringFromDate(date: date)
                }
            }
            .disposed(by: self.diposeBag)
        
        self.viewModel.output.sellDate
            .withUnretained(self)
            .bind { owner, date in
                if date != Date(timeIntervalSince1970: 0) {
                    owner.writingView.sellDateButton.dateLabel.text = self.viewModel.getDateStringFromDate(date: date)
                    owner.writingView.sellDateButton.timeLabel.text =
                    self.viewModel.getTimeStringFromDate(date: date)
                }
            }
            .disposed(by: self.diposeBag)
        
        self.viewModel.output.buySum
            .withUnretained(self)
            .bind { owner, sum in
                owner.writingView.buySumLabel.label.text = sum
            }
            .disposed(by: self.diposeBag)
        
        self.viewModel.output.sellSum
            .withUnretained(self)
            .bind { owner, sum in
                owner.writingView.sellSumLabel.label.text = sum
            }
            .disposed(by: self.diposeBag)
        
        self.viewModel.output.datePickerOpen
            .withUnretained(self)
            .bind { owner, flagNum in
                if flagNum == 1 {
                    owner.writingView.showDatePicker(date: self.viewModel.output.buyDate.value)
                } else if flagNum == 2 {
                    owner.writingView.showDatePicker(date: self.viewModel.output.sellDate.value)
                } else {
                    owner.writingView.hideDatePicker()
                }
            }
            .disposed(by: self.diposeBag)
        
        self.writingView.memoTextView.textView.rx.didBeginEditing
            .subscribe(onNext: {
                _ in if self.writingView.memoTextView.textView.text == self.writingView.memoTextView.textString {
                    self.writingView.memoTextView.textView.text = nil
                }
            })
            .disposed(by: self.diposeBag)
        
        self.writingView.memoTextView.textView.rx.didEndEditing
            .subscribe(onNext: {
                _ in if self.writingView.memoTextView.textView.text == nil || self.writingView.memoTextView.textView.text == "" {
                    self.writingView.memoTextView.textView.text = self.writingView.memoTextView.textString
                }
            })
            .disposed(by: self.diposeBag)
    }
}
