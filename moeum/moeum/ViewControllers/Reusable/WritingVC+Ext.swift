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
    func setup() {
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
    
    func binding() {
        self.writingView.tagTextField.textField.rx.text
            .subscribe(onNext: {
                s in
                print(s)
            })
            .disposed(by: self.diposeBag)
        
        self.writingView.buyDateButton.tapGesture.rx.event.bind(onNext: { recognizer in
            print("touches: \(recognizer.numberOfTouches)") //or whatever you like
            self.writingView.hideDatePicker()
        }).disposed(by: self.diposeBag)
        
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
