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
    
    var circleStackView = UIStackView()
        .then {
            $0.axis = .horizontal
            $0.spacing = 2
            $0.alignment = .center
        }
    
    var buyCircleView = UIView()
        .then {
            $0.backgroundColor = Const.Color.pink
            $0.layer.cornerRadius = 3
        }
    
    var sellCircleView = UIView()
        .then {
            $0.backgroundColor = Const.Color.mint
            $0.layer.cornerRadius = 3
        }
    
    var memoCirlceView = UIView()
        .then {
            $0.backgroundColor = .black
            $0.layer.cornerRadius = 3
        }
    
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
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
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
        circleStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        markClear()
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
        
        if records.contains(where: { $0.type == "매수"}) {
            circleStackView.addArrangedSubview(buyCircleView)
            NSLayoutConstraint.activate([
                buyCircleView.widthAnchor.constraint(equalToConstant: 6),
                buyCircleView.heightAnchor.constraint(equalToConstant: 6),
            ])
        }
        
        if records.contains(where: { $0.type == "매도"}) {
            circleStackView.addArrangedSubview(sellCircleView)
            NSLayoutConstraint.activate([
                sellCircleView.widthAnchor.constraint(equalToConstant: 6),
                sellCircleView.heightAnchor.constraint(equalToConstant: 6),
            ])
        }
        
        if records.contains(where: { $0.type == "메모" }) {
            circleStackView.addArrangedSubview(memoCirlceView)
            NSLayoutConstraint.activate([
                memoCirlceView.widthAnchor.constraint(equalToConstant: 6),
                memoCirlceView.heightAnchor.constraint(equalToConstant: 6),
            ])
        }
        
    }
    
    func show() {
        tagViews.forEach { $0.show() }
        UIView.animate(withDuration: 0.25, animations: {
            self.divider.alpha = 1
            self.circleStackView.alpha = 0
            self.layoutIfNeeded()
        })
    }
    
    func hide() {
        tagViews.forEach { $0.hide() }
        UIView.animate(withDuration: 0.25, animations: {
            self.divider.alpha = 0
            self.circleStackView.alpha = 1
            self.layoutIfNeeded()
        })
    }
    
    func markClear() {
        dateLabel.backgroundColor = .white
        dateLabel.textColor = .black
        dateLabel.font = .systemFont(ofSize: 10)
    }
    
    func markBlack() {
        dateLabel.backgroundColor = .black
        dateLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 10, weight: .bold)
    }
    
    func markGray() {
        dateLabel.backgroundColor = .lightGray
        dateLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 10)
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
        addSubview(circleStackView)
//        addSubview(buyCircleView)
//        addSubview(sellCircleView)
        addSubview(tagStackView)
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        circleStackView.translatesAutoresizingMaskIntoConstraints = false
        buyCircleView.translatesAutoresizingMaskIntoConstraints = false
        sellCircleView.translatesAutoresizingMaskIntoConstraints = false
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
            
            circleStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            circleStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleStackView.heightAnchor.constraint(equalToConstant: 10),

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
