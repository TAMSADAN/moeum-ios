//
//  MemoCalendarMonthPickerView.swift
//  moeum
//
//  Created by 송영모 on 2022/03/29.
//

import UIKit

class MemoCalendarMonthPickerView: UIView {
    
    lazy var contentView = UIView()
    lazy var monthLabel = UILabel()
    lazy var monthPickerButton = UIButton()
    
    func setup() {
        self.setupViews()
        self.setupLayouts()
    }
    
    private func setupViews() {
        self.setupContentView()
        self.setupMonthLabel()
        self.setupMonthPickerButton()
    }
    
    private func setupContentView() {
        self.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupMonthLabel() {
        self.contentView.addSubview(self.monthLabel)
        self.monthLabel.text = "2022.3"
        self.monthLabel.font = .systemFont(ofSize: 20, weight: .bold)
        self.monthLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupMonthPickerButton() {
        self.contentView.addSubview(self.monthPickerButton)
        self.monthPickerButton.setBackgroundImage(UIImage(systemName: "chevron.down"), for: .normal)
        self.monthPickerButton.tintColor = .black
        self.monthPickerButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.monthLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.monthLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            self.monthPickerButton.leadingAnchor.constraint(equalTo: self.monthLabel.trailingAnchor, constant: 5),
            self.monthPickerButton.centerYAnchor.constraint(equalTo: self.monthLabel.centerYAnchor),
            self.monthPickerButton.heightAnchor.constraint(equalToConstant: 20),
            self.monthPickerButton.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
}
