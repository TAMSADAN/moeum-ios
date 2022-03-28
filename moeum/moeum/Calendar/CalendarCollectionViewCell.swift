//
//  CalendarCollectionViewCell.swift
//  moeum
//
//  Created by 송영모 on 2022/03/19.
//

import UIKit

final class CalendarCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CalendarCollectionViewCell"
    public let calendar = Calendar.current
    public let dateFormatter = DateFormatter()
    
    lazy var topDividerView = UIView()
    lazy var dayLabel = UILabel()
    lazy var memoLineView = UIView()
    lazy var memoSummaryStackView = UIStackView()
    
    private var isLoaded = false
    private var cellMemoLineViewHeightConstraint: NSLayoutConstraint!
    private var memoSummaryStackViewHeightConstraint: NSLayoutConstraint!
    private var memoSummaryStackViewMaxHeight = CGFloat()
    private var memoSummaryViewMaxHeight = CGFloat()
    private var memoSummaryViewHeightConstraints: [NSLayoutConstraint]! = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        if frame.width != 0.0 && self.isLoaded == false {
            self.configure()
            self.isLoaded = true
        }
        self.memoSummaryStackViewMaxHeight = self.memoSummaryStackView.frame.height
    }
    
    private func testColor() {
        self.contentView.backgroundColor = .red
        self.topDividerView.backgroundColor = .yellow
        self.dayLabel.backgroundColor = .brown
        self.memoLineView.backgroundColor = .green
    }
    
    func update(date: Date) {
        if date == Date(timeIntervalSince1970: 0) {
            self.topDividerView.backgroundColor = .white
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
    
    public func hideMemoList() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveLinear,
                       animations: {
            self.memoSummaryStackView.alpha = 0
            for memoSummaryViewHeightConstraint in self.memoSummaryViewHeightConstraints {
                memoSummaryViewHeightConstraint.constant = 0
            }
            self.topDividerView.alpha = 0
        })
    }
    
    public func showMemoList() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .transitionCrossDissolve,
                       animations: {
            self.memoSummaryStackView.alpha = 1
            for memoSummaryViewHeightConstraint in self.memoSummaryViewHeightConstraints {
                memoSummaryViewHeightConstraint.constant = self.memoSummaryViewMaxHeight
            }
            self.topDividerView.alpha = 1
        })
    }
    
    private func configure() {
        self.configureTopDividerView()
        self.configureDayLabel()
        self.configureMemoSummaryStackView()
    }
    
    private func configureTopDividerView() {
        self.addSubview(self.topDividerView)
        self.topDividerView.backgroundColor = .systemGray
        self.topDividerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topDividerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.topDividerView.heightAnchor.constraint(equalToConstant: 0.2),
            self.topDividerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.topDividerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func configureDayLabel() {
        self.addSubview(self.dayLabel)
        self.dayLabel.font = .boldSystemFont(ofSize: 10)
        
        self.dayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dayLabel.topAnchor.constraint(equalTo: self.topDividerView.bottomAnchor, constant: 5),
            self.dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func configureMemoSummaryStackView() {
        self.memoSummaryStackView.axis = .vertical
        self.memoSummaryStackView.spacing = 3
        self.memoSummaryStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.memoSummaryStackView)
        
        NSLayoutConstraint.activate([
            self.memoSummaryStackView.topAnchor.constraint(equalTo: self.dayLabel.bottomAnchor),
            self.memoSummaryStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        self.memoSummaryViewMaxHeight = self.frame.height / 15
        for i in (0...Int.random(in: 0..<5)) {
            let memo = Memo(id: i, name:"테스트", price: Int.random(in: -1..<2))
            let memoSummaryView = MemoSummaryView(memo: memo)
            memoSummaryView.translatesAutoresizingMaskIntoConstraints = false
            let memoSummaryViewHeightConstraint = memoSummaryView.heightAnchor.constraint(equalToConstant: self.memoSummaryViewMaxHeight)
            memoSummaryViewHeightConstraint.isActive = true
            self.memoSummaryViewHeightConstraints.append(memoSummaryViewHeightConstraint)
            NSLayoutConstraint.activate([
                memoSummaryView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.9),
//                memoSummaryView.heightAnchor.constraint(equalToConstant: self.frame.height / 15),
            ])
            self.memoSummaryStackView.addArrangedSubview(memoSummaryView)
        }
    }
    
//    private func configureMemoLineView() {
//        self.addSubview(self.memoLineView)
//        self.memoLineView.backgroundColor = .init(red: 255/255, green: 218/255, blue: 68/255, alpha: 0.5)
//
//        self.memoLineView.translatesAutoresizingMaskIntoConstraints = false
//        self.cellMemoLineViewHeightConstraint = self.memoLineView.heightAnchor.constraint(equalToConstant: 10)
//        NSLayoutConstraint.activate([
//            self.memoLineView.topAnchor.constraint(equalTo: self.dayLabel.bottomAnchor),
//            self.memoLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 1),
//            self.memoLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -1),
//            self.memoLineView.heightAnchor.constraint(equalToConstant: 10),
//        ])
//
//        let tagView = UIView()
//        self.memoLineView.addSubview(tagView)
//        tagView.backgroundColor = .init(red: 255/255, green: 218/255, blue: 68/255, alpha: 1)
//
//        tagView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            tagView.topAnchor.constraint(equalTo: self.memoLineView.topAnchor),
//            tagView.leadingAnchor.constraint(equalTo: self.memoLineView.leadingAnchor),
//            tagView.bottomAnchor.constraint(equalTo: self.memoLineView.bottomAnchor),
//            tagView.widthAnchor.constraint(equalToConstant: 5),
//        ])
//
//        let contextLabel = UILabel()
//        self.memoLineView.addSubview(contextLabel)
//
//        contextLabel.text = "테스트"
//        contextLabel.font = .systemFont(ofSize: 8)
//
//        contextLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            contextLabel.topAnchor.constraint(equalTo: self.memoLineView.topAnchor),
//            contextLabel.leadingAnchor.constraint(equalTo: tagView.trailingAnchor, constant: 3),
//            contextLabel.trailingAnchor.constraint(equalTo: self.memoLineView.trailingAnchor),
//            contextLabel.bottomAnchor.constraint(equalTo: self.memoLineView.bottomAnchor),
//        ])
//    }
}
