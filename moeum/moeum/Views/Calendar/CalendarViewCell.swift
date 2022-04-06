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

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    func setup() {
        self.addSubview(self.tagStackView)
        
        self.tagStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for i in (0...Int.random(in: 0..<2)) {
            let memo = Memo(id: i, name:"테스트", price: Int.random(in: -1..<2))
            let tagLabel = TagLabel(memo: memo)
            
            
            self.tagStackView.addArrangedSubview(tagLabel)
        }
        
        NSLayoutConstraint.activate([
            self.tagStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.tagStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.tagStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
        ])
    }
}
