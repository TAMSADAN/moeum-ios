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
            $0.backgroundColor = .orange
        }
    
    var titleLabel = UILabel()
        .then {
            $0.text = "메모"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        }
    
    var noButton = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "xmark"), for: .normal)
            $0.tintColor = .white
        }
    
    var yesButton = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "checkmark"), for: .normal)
            $0.tintColor = .white
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
        self.addSubview(self.backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        self.addSubview(self.titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        self.addSubview(self.noButton)
        noButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            noButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            noButton.widthAnchor.constraint(equalToConstant: 35),
            noButton.heightAnchor.constraint(equalToConstant: 35),
        ])
        
        self.addSubview(yesButton)
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            yesButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            yesButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            yesButton.widthAnchor.constraint(equalToConstant: 35),
            yesButton.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
}
