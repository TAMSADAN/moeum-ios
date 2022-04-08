//
//  WritingVC+Bind.swift
//  moeum
//
//  Created by 송영모 on 2022/04/07.
//

import Foundation

extension WritingViewController {
    func setBind() {
        writingView.tagTextField.textField.rx.text.orEmpty
            .bind(to: viewModel.input.tagName)
            .disposed(by: disposeBag)
        
        writingView.nameTextField.textField.rx.text.orEmpty
            .bind(to: viewModel.input.itemName)
            .disposed(by: disposeBag)
        
        writingView.buyDateButton.tapGesture.rx.event
            .subscribe(onNext: { [weak self] _ in self?.viewModel.clickBuyDateButton() })
            .disposed(by: disposeBag)
        
        writingView.sellDateButton.tapGesture.rx.event
            .subscribe(onNext: { [weak self] _ in self?.viewModel.clickSellDateButton() })
            .disposed(by: disposeBag)
        
        writingView.datePicker.rx.date
            .bind(to: viewModel.input.date)
            .disposed(by: disposeBag)
        
        writingView.buyTextField.textField.rx.text.orEmpty
            .bind(to: viewModel.input.buyPrice)
            .disposed(by: disposeBag)
        
        writingView.sellTextField.textField.rx.text.orEmpty
            .bind(to: viewModel.input.sellPrice)
            .disposed(by: disposeBag)
        
        writingView.buyCountTextField.textField.rx.text.orEmpty
            .bind(to: viewModel.input.buyCount)
            .disposed(by: disposeBag)
        
        writingView.sellCountTextField.textField.rx.text.orEmpty
            .bind(to: viewModel.input.sellCount)
            .disposed(by: disposeBag)
        
        writingView.memoTextView.textView.rx.text.orEmpty
            .bind(to: viewModel.input.memo)
            .disposed(by: disposeBag)
        
        headerView.noButton.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.viewModel.input.noBtnFlag.onNext(true) })
            .disposed(by: disposeBag)
        
        headerView.yesButton.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.viewModel.input.yesBtnFlag.onNext(true) })
            .disposed(by: disposeBag)
        
        viewModel.output.buyDate
            .withUnretained(self)
            .bind { owner, date in
                if date != Date(timeIntervalSince1970: 0) {
                    owner.writingView.buyDateButton.dateLabel.text = owner.viewModel.getDateStringFromDate(date: date)
                    owner.writingView.buyDateButton.timeLabel.text =
                    owner.viewModel.getTimeStringFromDate(date: date)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.output.sellDate
            .withUnretained(self)
            .bind { owner, date in
                if date != Date(timeIntervalSince1970: 0) {
                    owner.writingView.sellDateButton.dateLabel.text = owner.viewModel.getDateStringFromDate(date: date)
                    owner.writingView.sellDateButton.timeLabel.text =
                    owner.viewModel.getTimeStringFromDate(date: date)
                }
            }
            .disposed(by: disposeBag)
        
        self.viewModel.output.buySum
            .withUnretained(self)
            .bind { owner, sum in
                owner.writingView.buySumLabel.label.text = sum
            }
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.sellSum
            .withUnretained(self)
            .bind { owner, sum in
                owner.writingView.sellSumLabel.label.text = sum
            }
            .disposed(by: self.disposeBag)
        
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
            .disposed(by: self.disposeBag)
        
        viewModel.output.pageState
            .withUnretained(self)
            .bind { [weak self] owner, state in
                if state == PageState.defult {
                    
                } else if state == PageState.back {
                    owner.goToBackVC()
                } else if state == PageState.next {
                    self?.viewModel.saveRecord()
                    owner.goToBackVC()
                }
                print(state)
            }
            .disposed(by: self.disposeBag)
        
        // TextView set placeholder
        self.writingView.memoTextView.textView.rx.didBeginEditing
            .subscribe(onNext: {
                _ in if self.writingView.memoTextView.textView.text == self.writingView.memoTextView.textString {
                    self.writingView.memoTextView.textView.text = nil
                }
            })
            .disposed(by: self.disposeBag)
        
        self.writingView.memoTextView.textView.rx.didEndEditing
            .subscribe(onNext: {
                _ in if self.writingView.memoTextView.textView.text == nil || self.writingView.memoTextView.textView.text == "" {
                    self.writingView.memoTextView.textView.text = self.writingView.memoTextView.textString
                }
            })
            .disposed(by: self.disposeBag)
    }
}
