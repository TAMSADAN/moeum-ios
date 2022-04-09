//
//  CalendarViewCell.swift
//  moeum
//
//  Created by 송영모 on 2022/04/05.
//

import UIKit
import Then

class CalendarViewCell: UICollectionViewCell {
    
    static let identifier = "CalendarCollectionViewCell"
    
    var tagStackView = UIStackView()
        .then {
            $0.axis = .vertical
            $0.spacing = 3
        }
    
    var tagLabel = UILabel()
    var tagLabelHeightConstraint: [NSLayoutConstraint] = []
    
    var date: Date!
    var records: [Record]!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
    }
    
    func update(date: Date, records: [Record]) {
        self.date = date
        self.records = records
        
        for record in records {
            let tagLabel = TagLabel(record: record)
            tagStackView.addArrangedSubview(tagLabel)
        }
    }
    
    func setView() {
        self.addSubview(self.tagStackView)
        
        self.tagStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tagStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.tagStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.tagStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
        ])
    }
}
