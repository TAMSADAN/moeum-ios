////
////  CalendarMemoView.swift
////  moeum
////
////  Created by 송영모 on 2022/03/22.
////
//
import UIKit

class CalendarMemoView: UIView {
    
    private var contentView = UIView()
    private var titleLabel = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    private func configure() {
        self.configureContentView()
        self.configureTitleLabel()
    }
    
    private func configureContentView() {
        self.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    private func configureTitleLabel() {
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.text = "22.수"
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
        ])
    }
}
