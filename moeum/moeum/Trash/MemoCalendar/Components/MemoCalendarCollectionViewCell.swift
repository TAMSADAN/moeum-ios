//
//  CalendarCollectionViewCell.swift
//  moeum
//
//  Created by 송영모 on 2022/03/19.
//

import UIKit

final class MemoCalendarCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CalendarCollectionViewCell"
    public let calendar = Calendar.current
    public let dateFormatter = DateFormatter()
    
    lazy var dividerView = UIView()
    lazy var dayLabel = UILabel()
    lazy var tagStackView = UIStackView()
    
    private var tagViewHeightConstraints: [NSLayoutConstraint]! = []
    private var tagViewDefaultWidth = CGFloat()
    private var tagViewDefaultHeight = CGFloat()
    
    func setup() {
        self.setupConstant()
        self.setupViews()
        self.setupLayouts()
    }
    
    private func setupConstant() {
        self.tagViewDefaultWidth = self.frame.width * 0.9
        self.tagViewDefaultHeight = self.frame.height / 15
    }
        
    private func setupViews() {
        self.setupContentView()
        self.setupDividerView()
        self.setupDayLabel()
        self.setupTagStackView()
    }
    
    private func setupContentView() {
        self.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupDividerView() {
        self.contentView.addSubview(self.dividerView)
        self.dividerView.translatesAutoresizingMaskIntoConstraints = false
        self.dividerView.backgroundColor = .systemGray
    }
    
    private func setupDayLabel() {
        self.contentView.addSubview(self.dayLabel)
        self.dayLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dayLabel.font = .boldSystemFont(ofSize: 10)
        
    }
    
    private func setupTagStackView() {
        self.contentView.addSubview(self.tagStackView)
        self.tagStackView.translatesAutoresizingMaskIntoConstraints = false
        self.tagStackView.axis = .vertical
        self.tagStackView.spacing = 3
        
        for i in (0...Int.random(in: 0..<5)) {
            let memo = Memo(id: i, name:"테스트", price: Int.random(in: -1..<2))
            let tagView = MemoCalendarViewCellTagView(memo: memo)
            tagView.setup()
            tagView.translatesAutoresizingMaskIntoConstraints = false
            let tagViewHeightConstraint = tagView.heightAnchor.constraint(equalToConstant: self.frame.height / 15)
            NSLayoutConstraint.activate([
                tagView.widthAnchor.constraint(equalToConstant: self.tagViewDefaultWidth),
                tagViewHeightConstraint,
            ])
            self.tagViewHeightConstraints.append(tagViewHeightConstraint)
            self.tagStackView.addArrangedSubview(tagView)
        }
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.dividerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.dividerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.dividerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.dividerView.heightAnchor.constraint(equalToConstant: 0.2),
            
            self.dayLabel.topAnchor.constraint(equalTo: self.dividerView.bottomAnchor, constant: 5),
            self.dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.tagStackView.topAnchor.constraint(equalTo: self.dayLabel.bottomAnchor),
            self.tagStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}

extension MemoCalendarCollectionViewCell {
    func update(date: Date) {
        if date == Date(timeIntervalSince1970: 0) {
            self.dividerView.backgroundColor = .white
            return
        } else {
            self.dayLabel.text = String(self.calendar.component(.day, from: date))
            
            if self.calendar.component(.weekday, from: date) == 1 {
                self.dayLabel.textColor = .systemRed
            } else if self.calendar.component(.weekday, from: date) == 7 {
                self.dayLabel.textColor = .systemBlue
            }
        }
    }
    
    func hideMemoList() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .transitionCrossDissolve,
                       animations: {
            self.tagStackView.alpha = 0
            for tagViewHeightConstraint in self.tagViewHeightConstraints {
                tagViewHeightConstraint.constant = 0
            }
            self.layoutIfNeeded()
            self.dividerView.alpha = 0
        })
    }
    
    func showMemoList() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .transitionCrossDissolve,
                       animations: {
            self.tagStackView.alpha = 1
            for tagViewHeightConstraint in self.tagViewHeightConstraints {
                tagViewHeightConstraint.constant = self.tagViewDefaultHeight
            }
            self.layoutIfNeeded()
            self.dividerView.alpha = 1
        })
    }
}
