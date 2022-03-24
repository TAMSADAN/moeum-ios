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
    private var topDividerView = UIView()
    private var titleLabel = UILabel()
    private var hideButton = UIButton()
    
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
        self.configureTopDividerView()
        self.configureHideButton()
        self.configureTitleLabel()
    }
    
    private func configureContentView() {
        self.addSubview(self.contentView)
        self.contentView.backgroundColor = .systemGray6
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    private func configureTopDividerView() {
        self.contentView.addSubview(self.topDividerView)
        self.topDividerView.backgroundColor = .systemGray
        
        self.topDividerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topDividerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.topDividerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.topDividerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.topDividerView.heightAnchor.constraint(equalToConstant: 0.4),
        ])
    }
    
    private func configureHideButton() {
        self.contentView.addSubview(self.hideButton)
        self.hideButton.tintColor = .systemGray3
        self.hideButton.setBackgroundImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        self.hideButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.hideButton.topAnchor.constraint(equalTo: self.topDividerView.bottomAnchor),
            self.hideButton.widthAnchor.constraint(equalToConstant: 45),
            self.hideButton.heightAnchor.constraint(equalToConstant: 25),
            self.hideButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
        ])
    }
    
    private func configureTitleLabel() {
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.text = "22. 수"
        self.titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topDividerView.bottomAnchor, constant: 10),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
        ])
    }
}
