//
//  WritingHeaderView.swift
//  moeum
//
//  Created by 송영모 on 2022/04/04.
//

import UIKit
import Then

class WritingHeaderView: UIView {
    
    var backgroundView = UIView()
        .then {
            $0.backgroundColor = .white
        }
    
    var titleLabel = UILabel()
        .then {
            $0.text = "메모"
            $0.textColor = .black
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        }
    
    var noButton = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "xmark"), for: .normal)
            $0.tintColor = .black
        }
    
    var yesButton = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "checkmark"), for: .normal)
            $0.tintColor = .black
        }
    
    var divider = UIView()
        .then {
            $0.backgroundColor = .lightGray
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    func setup() {
        addSubview(backgroundView)
        addSubview(titleLabel)
        addSubview(noButton)
        addSubview(yesButton)
        addSubview(divider)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        noButton.translatesAutoresizingMaskIntoConstraints = false
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            noButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            noButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            noButton.widthAnchor.constraint(equalToConstant: 35),
            noButton.heightAnchor.constraint(equalToConstant: 35),
            
            yesButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            yesButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            yesButton.widthAnchor.constraint(equalToConstant: 35),
            yesButton.heightAnchor.constraint(equalToConstant: 35),
            
            divider.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            divider.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 0.2),
        ])
    }
}
