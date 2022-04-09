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
            .bind(to: viewModel.input.tag)
            .disposed(by: disposeBag)
        
        writingView.itemTextField.textField.rx.text.orEmpty
            .bind(to: viewModel.input.item)
            .disposed(by: disposeBag)
        
        writingView.dateButton.tapGesture.rx.event
            .subscribe(onNext: {[weak self] _ in self?.viewModel.input.dateButtonTap.onNext(())})
            .disposed(by: disposeBag)

        writingView.datePicker.rx.date
            .bind(to: viewModel.input.date)
            .disposed(by: disposeBag)
        
        writingView.priceTextField.textField.rx.text.orEmpty
            .map{ Double($0) ?? 0.0 }
            .bind(to: viewModel.input.price)
            .disposed(by: disposeBag)
        
        writingView.countTextField.textField.rx.text.orEmpty
            .map{ Double($0) ?? 0.0 }
            .bind(to: viewModel.input.count)
            .disposed(by: disposeBag)
        
        writingView.memoTextView.textView.rx.text.orEmpty
            .bind(to: viewModel.input.memo)
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
        
        viewModel.output.datePickerOpen
            .withUnretained(self)
            .bind { [weak self] owner, bool in
                bool ? owner.writingView.showDatePicker(date: self?.viewModel.output.date.value ?? Date()) : owner.writingView.hideDatePicker()
            }
            .disposed(by: disposeBag)
        
        viewModel.output.date
            .withUnretained(self)
            .bind { [weak self] owner, date in
                owner.writingView.dateButton.dateLabel.text = self?.viewModel.getDateStringFromDate(date: date) ?? ""
                owner.writingView.dateButton.timeLabel.text = self?.viewModel.getTimeStringFromDate(date: date) ?? ""
            }
            .disposed(by: disposeBag)
        
        viewModel.output.sum
            .withUnretained(self)
            .bind { owner, sum in
                owner.writingView.sumLabel.label.text = sum
            }
            .disposed(by: disposeBag)
        
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
    
//    self.viewModel.output.datePickerOpen
//        .withUnretained(self)
//        .bind { owner, flagNum in
//            if flagNum == 1 {
//                owner.writingView.showDatePicker(date: self.viewModel.output.buyDate.value)
//            } else if flagNum == 2 {
//                owner.writingView.showDatePicker(date: self.viewModel.output.sellDate.value)
//            } else {
//                owner.writingView.hideDatePicker()
//            }
//        }
//        .disposed(by: self.disposeBag)
}
