//
//  CalendarViewCell.swift
//  moeum
//
//  Created by 송영모 on 2022/04/05.
//

import UIKit
import Then
import RxSwift

class CalendarViewCell: UICollectionViewCell {
    
    static let identifier = "CalendarCollectionViewCell"
    
    var tagViews: [TagLabel] = []
    
    var tagStackView = UIStackView()
        .then {
            $0.axis = .vertical
            $0.spacing = 15
        }
    
    var divider = UIView()
        .then {
            $0.backgroundColor = .lightGray
        }
    
    var dateLabel = UILabel()
        .then {
            $0.font = .systemFont(ofSize: 10)
            $0.textAlignment = .center
        }
    
    var date: Date!
    var records: [Record]!
    let dateFormatter = DateFormatter()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
    }
    
    override func prepareForReuse() {
        tagStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    func update(date: Date, records: [Record]) {
        self.date = date
        self.records = records
        
        
        for (index, record) in records.enumerated() {
            if index >= 5 {
                break
            }
            let tagLabel = TagLabel(record: record)
            tagViews.append(tagLabel)
            tagStackView.addArrangedSubview(tagLabel)
        }
        
        dateFormatter.dateFormat = "d"
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateLabel.text = dateFormatter.string(from: date)
        
        if isToday(date: date) {
            dateLabel.layer.cornerRadius = 10
            dateLabel.layer.masksToBounds = true
            dateLabel.backgroundColor = .black
            dateLabel.textColor = .white
            dateLabel.font = .systemFont(ofSize: 10, weight: .bold)
        }
    }
    
    func show() {
        tagViews.forEach { $0.show() }
        UIView.animate(withDuration: 0.25, animations: {
            self.divider.alpha = 1
            self.layoutIfNeeded()
        })
    }
    
    func hide() {
        tagViews.forEach { $0.hide() }
        UIView.animate(withDuration: 0.25, animations: {
            self.divider.alpha = 0
            self.layoutIfNeeded()
        })
    }
    
    func showHighlight() {
        if !isToday(date: self.date) {
            dateLabel.layer.cornerRadius = 10
            dateLabel.layer.masksToBounds = true
            dateLabel.backgroundColor = .lightGray
            dateLabel.textColor = .white
            dateLabel.font = .systemFont(ofSize: 10)
        }
    }
    
    func hideHighlight() {
        if !isToday(date: self.date) {
            dateLabel.layer.cornerRadius = 0
            dateLabel.backgroundColor = .white
            dateLabel.textColor = .black
            dateLabel.font = .systemFont(ofSize: 10)
        }
    }
    
    func setView() {
        addSubview(divider)
        addSubview(dateLabel)
        addSubview(tagStackView)
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        tagStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: topAnchor),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 0.18),
            
            dateLabel.topAnchor.constraint(equalTo: divider.bottomAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 20),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),

            tagStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            tagStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            tagStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
        ])
    }
    
    private func isToday(date: Date) -> Bool {
        let c1 = Calendar.current.dateComponents(in: TimeZone(identifier: "UTC")!, from: Date())
        let c2 = Calendar.current.dateComponents(in: TimeZone(identifier: "UTC")!, from: date)
        
        if c1.year == c2.year && c1.month == c2.month && c1.day == c2.day {
            return true
        } else {
            return false
        }
    }
}
