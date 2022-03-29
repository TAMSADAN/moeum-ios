//
//  MemoCalendarViewController.swift
//  moeum
//
//  Created by 송영모 on 2022/03/29.
//

import UIKit

class MemoCalendarViewController: UIViewController {
    private lazy var contentView = UIView()
    private lazy var memoCalendarView = MemoCalendarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    private func configure() {
        self.view.backgroundColor = .systemBackground
        self.configureContentView()
        self.configureMemoCalendarView()
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
    
    private func configureMemoCalendarView() {
        self.contentView.addSubview(self.memoCalendarView)
        
        self.memoCalendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.memoCalendarView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.memoCalendarView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.memoCalendarView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.memoCalendarView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
    
}
