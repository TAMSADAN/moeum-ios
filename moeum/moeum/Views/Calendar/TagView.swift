//
//  TagView.swift
//  moeum
//
//  Created by 송영모 on 2022/04/05.
//

import UIKit

class TagView: UIView {
    
    var memo: Memo!
    
    var tagView = UIView()
    
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
        if memo.price > 0 {
            self.backgroundColor = UIColor.orange
            self.tagView.backgroundColor = .cyan
        } else {
            self.backgroundColor = .purple
            self.tagView.backgroundColor = .brown
        }
        
        self.addSubview(self.tagView)
        self.tagView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tagView.topAnchor.constraint(equalTo: self.topAnchor),
            self.tagView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tagView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.tagView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.1),
        ])
    }
}
