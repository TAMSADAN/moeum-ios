//
//  TrashButton.swift
//  moeum
//
//  Created by 송영모 on 2022/04/18.
//

import UIKit

class TrashButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    func setup() {
        self.tintColor = .black
        self.backgroundColor = .white
        self.contentHorizontalAlignment = .fill
        self.contentVerticalAlignment = .fill
        self.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
        self.layer.cornerRadius = 21
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 42),
            self.heightAnchor.constraint(equalToConstant: 42),
        ])
    }
}
