//
//  HistoryLabel.swift
//  moeum
//
//  Created by 송영모 on 2022/04/12.
//

import UIKit
import Then

class BuyHistoryLabel: UIView {
    
    var contentView = UIView()
    
    var itemLabel = UILabel()
        .then {
            $0.font = Const.Font.subheadline
        }
    
    var recordZip: RecordZip!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    func update(recordZip: RecordZip) {
        self.recordZip = recordZip
        
        itemLabel.text = self.recordZip.record.item
    }
    
    func setView() {
        addSubview(contentView)
        contentView.addSubview(itemLabel)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            itemLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
}
