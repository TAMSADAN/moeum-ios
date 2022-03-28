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
    
//    var memo: Memo?
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//
//    init(frame: CGRect, memo: Memo) {
//        super.init(frame: frame)
//        self.memo = memo
//        self.configure()
//    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.configure()
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.configureContentView()
        self.configureTagView()
    }
    
    private func configureContentView() {
        self.addSubview(contentView)
        self.backgroundColor = .red
        
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
        
//        if memo!.price > 0 {
//            self.tagView.backgroundColor = .systemRed
//        } else {
//            self.tagView.backgroundColor = .systemBlue
//        }
        
        self.tagView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tagView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.tagView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.tagView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.tagView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.3)
        ])
    }
    
    private func configureTitleLabel() {
        self.contentView.addSubview(self.titleLabel)
    }
}
