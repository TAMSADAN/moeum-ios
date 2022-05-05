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
        view.addSubview(headerView)
        view.addSubview(writingView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        writingView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            writingView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            writingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            writingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            writingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension WritingViewController {
    func setBind() {
        writingView.tagTextField.textField.rx.text.orEmpty
            .bind(to: viewModel.input.tag)
            .disposed(by: disposeBag)
        
        writingView.itemTextField.textField.rx.text.orEmpty
            .bind(to: viewModel.input.item)
            .disposed(by: disposeBag)
        
        writingView.typeSegment.rx.selectedSegmentIndex
            .bind(to: viewModel.input.typeIndex)
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
        
        writingView.deleteButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.viewModel.recordService.deleteRecord(recordId: owner.viewModel.record.id)
                owner.goToBackVC()
            }
            .disposed(by: disposeBag)
        
        headerView.noButton.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.viewModel.input.noBtnFlag.onNext(true) })
            .disposed(by: disposeBag)
        
        headerView.yesButton.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.viewModel.input.yesBtnFlag.onNext(true) })
            .disposed(by: disposeBag)
        
//        viewModel.output.itemHistoryOpen
//            .withUnretained(self)
//            .bind { owner, bool in
//                bool ? owner.writingView.showItemHistoryView() : owner.writingView.hideItemHistoryView()
//            }
//            .disposed(by: disposeBag)
        
//        viewModel.output.itemHistoryRecordZips
//            .withUnretained(self)
//            .subscribe(onNext: {
//                [weak self] owner, recordZips in
//                owner.writingView.itemHistoryView.update(recordZips: recordZips)
//            })
//            .disposed(by: disposeBag)
        
        viewModel.output.datePickerOpen
            .withUnretained(self)
            .bind { [weak self] owner, bool in
                bool ? owner.writingView.showDatePicker(date: self?.viewModel.output.date.value ?? Date()) : owner.writingView.hideDatePicker()
            }
            .disposed(by: disposeBag)
        
        viewModel.output.itemCaption
            .withUnretained(self)
            .bind { owner, data in
                owner.writingView.itemTextField.captionLabel.text = data.0
                if data.1 == 1 {
                    owner.writingView.itemTextField.captionLabel.textColor = .systemGreen
                } else if data.1 == 2 {
                    owner.writingView.itemTextField.captionLabel.textColor = .systemRed
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.output.countCaption
            .withUnretained(self)
            .bind { owner, data in
                owner.writingView.countTextField.captionLabel.text = data.0
                if data.1 == 1 {
                    owner.writingView.countTextField.captionLabel.textColor = .systemGreen
                } else if data.1 == 2 {
                    owner.writingView.countTextField.captionLabel.textColor = .systemRed
                }
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
}

extension WritingViewController {
    func update(record: Record) {
        self.viewModel.record = record
        self.writingView.tagTextField.textField.text = record.tag
        self.writingView.itemTextField.textField.text = record.item
        self.writingView.typeSegment.selectedSegmentIndex = types.firstIndex(of: record.type) ?? 0
        self.writingView.datePicker.date = record.date
        self.writingView.priceTextField.textField.text = String(record.price)
        self.writingView.countTextField.textField.text = String(record.count)
        self.writingView.memoTextView.textView.text = record.memo
    }
    
    func goToBackVC() {
        self.dismiss(animated: false, completion: nil)
    }
}
