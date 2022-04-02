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
    lazy var lineStackView = UIStackView()
    lazy var lineViews: [MemoCalendarBottomSheetLineView] = []
    
    func setup() {
        self.setupViews()
        self.setupLayouts()
    }
    
    private func setupViews() {
        self.setupContentView()
        self.setupDayLabel()
        self.setupHideButton()
        self.setupLineStackView()
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
        self.hideButton.translatesAutoresizingMaskIntoConstraints = false
        self.hideButton.tintColor = .systemGray3
        self.hideButton.setBackgroundImage(UIImage(systemName: "minus"), for: .normal)
    }
    
    private func setupLineStackView() {
        self.contentView.addSubview(self.lineStackView)
        self.lineStackView.translatesAutoresizingMaskIntoConstraints = false
        self.lineStackView.axis = .vertical
        self.lineStackView.spacing = 3
        
        for i in (0...Int.random(in: 0..<5)) {
            let lineView = MemoCalendarBottomSheetLineView(width: self.frame.width * 0.95)
            lineView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                lineView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.95),
                lineView.heightAnchor.constraint(equalToConstant: self.frame.height / 30)
            ])
            lineView.setup()
            self.lineViews.append(lineView)
            self.lineStackView.addArrangedSubview(lineView)
        }
    }
    
    private func setupLayouts() {
        
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.dayLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.dayLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            
            self.hideButton.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.hideButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.hideButton.widthAnchor.constraint(equalToConstant: 30),
            self.hideButton.heightAnchor.constraint(equalToConstant: 24),

            self.lineStackView.topAnchor.constraint(equalTo: self.dayLabel.bottomAnchor, constant: 10),
            self.lineStackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
//            self.lineStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        for lineView in self.lineViews {
            
        }
    }
}
