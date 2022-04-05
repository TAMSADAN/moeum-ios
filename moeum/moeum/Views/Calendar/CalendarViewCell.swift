//
//  CalendarViewCell.swift
//  moeum
//
//  Created by 송영모 on 2022/04/05.
//

import UIKit
import Then

class CalendarViewCell: UICollectionViewCell {
    
    var tagView = UIView()
        .then {
            $0.backgroundColor = .systemRed
        }
    var tagLabel = UILabel()
    
    var memo: Memo!

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
