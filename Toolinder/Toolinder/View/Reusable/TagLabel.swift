//
//  TagLabel.swift
//  moeum
//
//  Created by 송영모 on 2022/04/06.
//

import UIKit
import Then
import SwiftUI

class TagLabel: UIView {
    
    var record: Record!
    
    var contentView = UIView()
        .then {
            $0.layer.cornerRadius = 3
        }
    
    var tagView = UIView()
        .then {
            $0.layer.cornerRadius = 3
        }
    
    var label = UILabel()
        .then {
            $0.font = .systemFont(ofSize: 8, weight: .bold)
            $0.textColor = .white
        }
    
    var ContentViewHeightConstraint = NSLayoutConstraint()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    init(record: Record) {
        super.init(frame: .zero)
        self.record = record
        self.setup()
    }
    
    func show() {
        ContentViewHeightConstraint.constant = 12
        UIView.animate(withDuration: 0.25, animations: {
            self.ContentViewHeightConstraint.isActive = true
            self.layoutIfNeeded()
        })
    }
    
    func hide() {
        ContentViewHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.25, animations: {
            self.ContentViewHeightConstraint.isActive = true
            self.layoutIfNeeded()
        })
    }
    
    func setup() {
        addSubview(contentView)
        contentView.addSubview(tagView)
        contentView.addSubview(label)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        tagView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if record.type == "매수" {
            contentView.backgroundColor = Const.Color.pink
            tagView.backgroundColor = Const.Color.pink
        } else if record.type == "매도" {
            contentView.backgroundColor = Const.Color.mint
            tagView.backgroundColor = Const.Color.mint
        }
        
        label.text = record.item
        
        ContentViewHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: 12)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ContentViewHeightConstraint,
            
            tagView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tagView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tagView.widthAnchor.constraint(equalToConstant: 3),
            
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: tagView.trailingAnchor, constant: 2),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
