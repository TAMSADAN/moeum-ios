//
//  MemoCalendarViewCellTagView.swift
//  moeum
//
//  Created by 송영모 on 2022/03/31.
//

import UIKit

class MemoCalendarViewCellTagView: UIView {
    lazy var contentView = UIView()
    lazy var tagView = UIView()
    lazy var tagLabel = UILabel()
    
    var memo: Memo!
    let customRed = UIColor.init(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
    let customBlurRed = UIColor.init(red: 255/255, green: 102/255, blue: 102/255, alpha: 0.3)
    let customBlue = UIColor.init(red: 102/255, green: 168/255, blue: 255/255, alpha: 1)
    let customBlurBlue = UIColor.init(red: 102/255, green: 168/255, blue: 255/255, alpha: 0.3)

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(memo: Memo) {
        super.init(frame: .zero)
        self.memo = memo
    }
    
    func setup() {
        self.setupViews()
        self.setupLayouts()
    }
    
    private func setupViews() {
        self.setupContentView()
        self.setupTagView()
        self.setupTagLabel()
    }
    
    private func setupContentView() {
        self.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        if memo.price > 0 {
            self.contentView.backgroundColor = self.customBlurRed
        } else {
            self.contentView.backgroundColor = self.customBlurBlue
        }
    }
    
    private func setupTagView() {
        self.contentView.addSubview(self.tagView)
        self.tagView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTagLabel() {
        self.contentView.addSubview(self.tagLabel)
        self.tagLabel.translatesAutoresizingMaskIntoConstraints = false
        self.tagLabel.text = self.memo.name
        self.tagLabel.font = .systemFont(ofSize: 8)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.tagView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.tagView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.tagView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.tagView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.05),
            
            self.tagLabel.leadingAnchor.constraint(equalTo: self.tagView.trailingAnchor, constant: 1),
            self.tagLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
}
