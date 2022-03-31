//
//  MemoCalendarBottomSheetView.swift
//  moeum
//
//  Created by 송영모 on 2022/03/31.
//

import UIKit

class MemoCalendarBottomSheetView: UIView {

    lazy var contentView = UIView()
    lazy var dayLabel = UILabel()
    lazy var hideButton = UIButton()
    
    func setup() {
        self.setupViews()
        self.setupLayouts()
    }
    
    private func setupViews() {
        self.setupContentView()
        self.setupDayLabel()
    }
    
    private func setupContentView() {
        self.addSubview(self.contentView)
        self.contentView.backgroundColor = .systemGray6
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupDayLabel() {
        self.contentView.addSubview(self.dayLabel)
        self.dayLabel.text = "3.31 수"
        self.dayLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        self.dayLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupHideButton() {
        self.contentView.addSubview(self.hideButton)
        self.hideButton
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.dayLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.dayLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
        ])
    }
}
