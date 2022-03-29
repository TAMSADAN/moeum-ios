//
//  MemoCalendarViewController.swift
//  moeum
//
//  Created by 송영모 on 2022/03/29.
//

import UIKit

class MemoCalendarViewController: UIViewController {
    private var contentView = UIView()
    private lazy var memoCalendarDatePickerView = MemoCalendarDatePickerView()
    private lazy var memoCalendarWeekView = MemoCalendarWeekView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    private func configure() {
        self.view.backgroundColor = .systemBackground
        self.configureContentView()
        self.configureMemoCalendarDatePickerView()
        self.configureMemoCalendarWeekView()
    }
    
    private func configureContentView() {
        self.view.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configureMemoCalendarDatePickerView() {
        self.contentView.addSubview(self.memoCalendarDatePickerView)
        
        self.memoCalendarDatePickerView.dateLabel.text = "2023.3"
        self.memoCalendarDatePickerView.backgroundColor = .red
        
        self.memoCalendarDatePickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.memoCalendarDatePickerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.memoCalendarDatePickerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
//            self.memoCalendarDatePickerView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor)
        ])
    }
    
    private func configureMemoCalendarWeekView() {
        self.contentView.addSubview(self.memoCalendarWeekView)
        
        self.memoCalendarWeekView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.memoCalendarWeekView.topAnchor.constraint(equalTo: self.memoCalendarDatePickerView.bottomAnchor),
            self.memoCalendarWeekView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.memoCalendarWeekView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
}
