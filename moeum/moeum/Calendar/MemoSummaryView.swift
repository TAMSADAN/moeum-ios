//
//  MemoSummaryView.swift
//  moeum
//
//  Created by 송영모 on 2022/03/28.
//

import UIKit

class MemoSummaryView: UIView {
    lazy var contentView = UIView()
    lazy var tagView = UIView()
    lazy var titleLabel = UILabel()
    
    private var memo: Memo!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(memo: Memo) {
        super.init(frame: .zero)
        self.memo = memo
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.configure()
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.configureContentView()
        self.configureTagView()
        self.configureTitleLabel()
        self.configureBackgroundColor()
    }
    
    private func configureBackgroundColor() {
        if memo.price > 0 {
            self.contentView.backgroundColor = .init(red: 255/255, green: 102/255, blue: 102/255, alpha: 0.3)
            self.tagView.backgroundColor = .init(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        } else {
            self.contentView.backgroundColor = .init(red: 102/255, green: 168/255, blue: 255/255, alpha: 0.3)
            self.tagView.backgroundColor = .init(red: 102/255, green: 168/255, blue: 255/255, alpha: 1)
        }
    }
    
    private func configureContentView() {
        self.addSubview(contentView)
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    private func configureTagView() {
        self.contentView.addSubview(self.tagView)
        
        self.tagView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tagView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.tagView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.tagView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.tagView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.05)
        ])
    }
    
    private func configureTitleLabel() {
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.text = memo.name
        self.titleLabel.font = .systemFont(ofSize: 8)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.tagView.trailingAnchor, constant: 1),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
}
