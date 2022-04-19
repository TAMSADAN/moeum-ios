//
//  MemoCalendarBottomSheetLineView.swift
//  moeum
//
//  Created by 송영모 on 2022/04/01.
//

import UIKit

class MemoCalendarBottomSheetLineView: UIView {
    
    lazy var contentView = UIView()
    lazy var tradingLabel = UILabel()
    lazy var tagLabel = UILabel()
    lazy var nameLabel = UILabel()
    lazy var volumeLabel = UILabel()
    lazy var memoLabel = UILabel()
    
    private var frameWidth = CGFloat()
    private var tradingLabelWidth = CGFloat()
    private var tagLabelWidth = CGFloat()
    private var nameLabelWidth = CGFloat()
    private var volumeLabelWidth = CGFloat()
    private var memoLabelWidth = CGFloat()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(width: CGFloat) {
        super.init(frame: .zero)
        self.frameWidth = width
    }
    
    func setup() {
        self.setupConstants()
        self.setupViews()
        self.setupLayouts()
    }
    
    private func setupViews() {
        self.setupContentView()
        self.setupTradingLabel()
        self.setupTagLabel()
        self.setupNameLabel()
        self.setupVolumeLabel()
        self.setupMemoLabel()
    }
    
    private func setupConstants() {
        self.tradingLabelWidth = self.frameWidth * 0.07
        self.tagLabelWidth = self.frameWidth * 0.1
        self.nameLabelWidth = self.frameWidth * 0.15
        self.volumeLabelWidth = self.frameWidth * 0.2
        self.memoLabelWidth = self.frameWidth * 0.5
    }
    
    private func setupContentView() {
        self.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTradingLabel() {
        self.contentView.addSubview(self.tradingLabel)
        self.tradingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.tradingLabel.adjustsFontSizeToFitWidth = true
        self.tradingLabel.text = "매수"
        self.tradingLabel.textColor = .systemRed
        self.tradingLabel.textAlignment = .center
    }
    
    private func setupTagLabel() {
        self.contentView.addSubview(self.tagLabel)
        self.tagLabel.translatesAutoresizingMaskIntoConstraints = false
        self.tagLabel.adjustsFontSizeToFitWidth = true
        self.tagLabel.text = "코인"
        self.tagLabel.textAlignment = .center
    }
    
    private func setupNameLabel() {
        self.contentView.addSubview(self.nameLabel)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.adjustsFontSizeToFitWidth = true
        self.nameLabel.text = "비트코인"
        self.nameLabel.textAlignment = .center
    }
    
    private func setupVolumeLabel() {
        self.contentView.addSubview(self.volumeLabel)
        self.volumeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.volumeLabel.adjustsFontSizeToFitWidth = true
        self.volumeLabel.text = "123,405"
        self.volumeLabel.textAlignment = .right
    }
    
    private func setupMemoLabel() {
        self.contentView.addSubview(self.memoLabel)
        self.memoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.memoLabel.adjustsFontSizeToFitWidth = true
        self.memoLabel.text = "메모😥"
        self.memoLabel.textAlignment = .center
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.tradingLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.tradingLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            self.tradingLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.tradingLabel.widthAnchor.constraint(equalToConstant: self.tradingLabelWidth),
            
            self.tagLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.tagLabel.leadingAnchor.constraint(equalTo: self.tradingLabel.trailingAnchor, constant: 5),
            self.tagLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.tagLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.tagLabel.widthAnchor.constraint(equalToConstant: self.tagLabelWidth),
            
            self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.tagLabel.trailingAnchor, constant: 5),
            self.nameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.nameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.nameLabel.widthAnchor.constraint(equalToConstant: self.nameLabelWidth),
            
            self.volumeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.volumeLabel.leadingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor, constant: 5),
            self.volumeLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.volumeLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.volumeLabel.widthAnchor.constraint(equalToConstant: self.volumeLabelWidth),
            
            self.memoLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.memoLabel.leadingAnchor.constraint(equalTo: self.volumeLabel.trailingAnchor, constant: 5),
            self.memoLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.memoLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.memoLabel.widthAnchor.constraint(equalToConstant: self.memoLabelWidth),
        ])
    }
}
