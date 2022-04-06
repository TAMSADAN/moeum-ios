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
                _ in self.viewModel.input.isClickedBuyDateButton.onNext(true)
            })
            .disposed(by: self.diposeBag)
        
        self.writingView.sellDateButton.tapGesture.rx.event
            .subscribe(onNext: {
                _ in self.viewModel.input.isClickedSellDateButton.onNext(true)
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
        
        self.writingView.memoTextView.textView.rx.didBeginEditing
            .subscribe(onNext: {
                s in if self.writingView.memoTextView.textView.text == self.writingView.memoTextView.textString {
                        self.writingView.memoTextView.textView.text = nil
                    }
            })
            .disposed(by: self.diposeBag)
        
        self.writingView.memoTextView.textView.rx.didEndEditing
            .subscribe(onNext: {
                s in if self.writingView.memoTextView.textView.text == nil || self.writingView.memoTextView.textView.text == "" {
                    self.writingView.memoTextView.textView.text = self.writingView.memoTextView.textString
                }
                print(s)
//                self.viewModel.input.memo.onNext(s)
            })
            .disposed(by: self.diposeBag)
    }
}
