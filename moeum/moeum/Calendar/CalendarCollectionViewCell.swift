//
//  CalendarCollectionViewCell.swift
//  moeum
//
//  Created by 송영모 on 2022/03/19.
//

import UIKit

final class CalendarCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CalendarCollectionViewCell"
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    
    private lazy var cellView = UIView()
    private lazy var headerLine = UIView()
    private lazy var dayLabel = UILabel()
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
//    override func prepareForReuse() {
//        self.dayLabel.text = nil
//    }
    
    func update(date: Date) {
        if date == Date(timeIntervalSince1970: 0) {
            self.headerLine.backgroundColor = .white
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
    
    private func configure() {
        self.configureCellView()
        self.configureHeaderLine()
        self.configureDayLabel()
        
    }
    
    private func configureCellView() {
        self.addSubview(self.cellView)
        self.cellView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.cellView.topAnchor.constraint(equalTo: self.topAnchor),
            self.cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    private func configureHeaderLine() {
        self.cellView.addSubview(self.headerLine)
        self.headerLine.backgroundColor = .black
        self.headerLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.headerLine.topAnchor.constraint(equalTo: self.cellView.topAnchor),
            self.headerLine.heightAnchor.constraint(equalToConstant: 0.2),
            self.headerLine.leadingAnchor.constraint(equalTo: self.cellView.leadingAnchor),
            self.headerLine.trailingAnchor.constraint(equalTo: self.cellView.trailingAnchor)
        ])
    }
    
    private func configureDayLabel() {
        self.cellView.addSubview(self.dayLabel)
        self.dayLabel.font = .boldSystemFont(ofSize: 10)
        self.dayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dayLabel.topAnchor.constraint(equalTo: self.headerLine.topAnchor, constant: 5),
            self.dayLabel.centerXAnchor.constraint(equalTo: self.cellView.centerXAnchor)
        ])
    }
}