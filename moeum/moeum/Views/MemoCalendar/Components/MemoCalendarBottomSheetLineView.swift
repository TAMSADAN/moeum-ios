//
//  MemoCalendarBottomSheetLineView.swift
//  moeum
//
//  Created by 송영모 on 2022/04/01.
//

import UIKit

class MemoCalendarBottomSheetLineView: UIView {
    
    lazy var contentView = UIView()
    lazy var tagView = UIView()
    
    func setup() {
        self.setupViews()
        self.setupLayouts()
    }
    
    private func setupViews() {
        self.setupContentView()
        self.setupCircleView()
    }
    
    private func setupContentView() {
        self.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.backgroundColor = .systemBlue
    }
    
    private func setupCircleView() {
        self.contentView.addSubview(self.tagView)
        self.tagView.translatesAutoresizingMaskIntoConstraints = false
        self.tagView.backgroundColor = .green
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
            self.tagView.widthAnchor.constraint(equalToConstant: 5)
        ])
    }
}
