//
//  MemoCalendarDatePickerView.swift
//  moeum
//
//  Created by 송영모 on 2022/03/29.
//

import UIKit

class MemoCalendarDatePickerView: UIView {
    
    lazy var contentView = UIView()
    lazy var dateLabel = UILabel()
    lazy var datePickerButton = UIButton()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        self.configure()
    }
    
    init() {
        super.init(frame: .zero)
//        self.configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configure()
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.configureContentView()
        self.configureDateLabel()
        self.configureDatePickerButton()
    }
    
    private func configureContentView() {
        self.addSubview(self.contentView)
        self.contentView.backgroundColor = .red
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
    }
    
    
    private func configureDateLabel() {
        self.addSubview(self.dateLabel)
        
        self.dateLabel.font = .systemFont(ofSize: 20, weight: .bold)
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dateLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
    }
    
    private func configureDatePickerButton() {
        self.addSubview(self.datePickerButton)
        
        self.datePickerButton.setBackgroundImage(UIImage(systemName: "chevron.down"), for: .normal)
        self.datePickerButton.tintColor = .black
        
        self.datePickerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.datePickerButton.leadingAnchor.constraint(equalTo: self.dateLabel.trailingAnchor, constant: 5),
            self.datePickerButton.centerYAnchor.constraint(equalTo: self.dateLabel.centerYAnchor),
            self.datePickerButton.heightAnchor.constraint(equalToConstant: 20),
            self.datePickerButton.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
}
