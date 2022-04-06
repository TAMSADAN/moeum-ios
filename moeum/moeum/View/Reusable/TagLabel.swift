//
//  TagLabel.swift
//  moeum
//
//  Created by 송영모 on 2022/04/06.
//

import UIKit
import Then

class TagLabel: UIView {
    
    var memo: Memo!
    
    var tagView = UIView()
        .then {
            $0.backgroundColor = .red
        }
    
    var label = UILabel()
        .then {
            $0.backgroundColor = .systemYellow
            $0.font = .systemFont(ofSize: 8)
        }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    init(memo: Memo) {
        super.init(frame: .zero)
        self.memo = memo
        self.setup()
    }
    
    func setup() {
        self.addSubview(self.tagView)
        self.addSubview(self.label)
        
        self.tagView.translatesAutoresizingMaskIntoConstraints = false
        self.label.translatesAutoresizingMaskIntoConstraints = false
        
        self.label.text = self.memo.name
        
        NSLayoutConstraint.activate([
            self.tagView.topAnchor.constraint(equalTo: self.topAnchor),
            self.tagView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tagView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tagView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.label.topAnchor.constraint(equalTo: self.topAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
            self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
