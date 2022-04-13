//
//  TagLabel.swift
//  moeum
//
//  Created by 송영모 on 2022/04/06.
//

import UIKit
import Then

class TagLabel: UIView {
    
    var record: Record!
    
    var contentView = UIView()
        .then {
            $0.backgroundColor = .systemYellow
            $0.layer.cornerRadius = 3
        }
    
    var tagView = UIView()
        .then {
            $0.backgroundColor = .red
            $0.layer.cornerRadius = 3
        }
    
    var label = UILabel()
        .then {
            $0.font = .systemFont(ofSize: 8)
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