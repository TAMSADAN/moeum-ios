//
//  MiniCalendarCVC.swift
//  Toolinder
//
//  Created by 송영모 on 2022/07/03.
//

import UIKit
import SnapKit

class MiniCalendarCVC: BaseCVC {
    static let id = "MiniCalendarCVC"
    
    let label = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .clear
        
        label.text = "1"
        label.textAlignment = .center
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(label)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
}
