//
//  CalendarCollectionViewCell.swift
//  moeum
//
//  Created by 송영모 on 2022/03/19.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    static let identifier = "CalendarCollectionViewCell"
    private lazy var dayLabel = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    private func configure() {
        
    }
}
