//
//  WritingView.swift
//  moeum
//
//  Created by 송영모 on 2022/04/04.
//

import UIKit
import Then

class WritingView: UIView {
    
    var tradeSegment = UISegmentedControl(items: ["매수", "매도", "메모"])
        .then {
            $0.selectedSegmentIndex = 1
        }
    
    var tagImageView = UIImageView(image: UIImage(systemName: "tag"))
        .then {
            $0.tintColor = .black
            $0.contentMode = .scaleAspectFit
        }
    
    var tagTextView = UITextField()
        .then {
            $0.attributedPlaceholder = NSAttributedString(string: "태그", attributes: [.foregroundColor: UIColor.black])
            $0.tintColor = .systemBlue
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 15)
            $0.textAlignment = .left
            $0.contentMode = .scaleToFill
            $0.isMultipleTouchEnabled = false
        }
    
    var nameImageView = UIImageView(image: UIImage(systemName: "centsign.circle"))
        .then {
            $0.tintColor = .black
            $0.contentMode = .scaleAspectFit
        }
    
    var nameTextView = UITextField()
        .then {
            $0.attributedPlaceholder = NSAttributedString(string: "종목명", attributes: [.foregroundColor: UIColor.black])
            $0.tintColor = .darkGray
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 15)
            $0.isMultipleTouchEnabled = false
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
        self.addSubview(self.tagImageView)
        self.tagImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tagImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            self.tagImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.tagImageView.widthAnchor.constraint(equalToConstant: 20),
            self.tagImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        self.addSubview(self.tagTextView)
        self.tagTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tagTextView.leadingAnchor.constraint(equalTo: self.tagImageView.trailingAnchor, constant: 5),
            self.tagTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tagTextView.centerYAnchor.constraint(equalTo: self.tagImageView.centerYAnchor),
        ])
        
        self.addSubview(self.nameImageView)
        self.nameImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.nameImageView.topAnchor.constraint(equalTo: self.tagImageView.bottomAnchor, constant: 15),
            self.nameImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.nameImageView.widthAnchor.constraint(equalToConstant: 20),
            self.nameImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        self.addSubview(self.nameTextView)
        self.nameTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.nameTextView.leadingAnchor.constraint(equalTo: self.tagImageView.trailingAnchor, constant: 5),
            self.nameTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.nameTextView.centerYAnchor.constraint(equalTo: self.nameImageView.centerYAnchor),
        ])
        
        self.addSubview(self.tradeSegment)
        self.tradeSegment.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tradeSegment.topAnchor.constraint(equalTo: self.nameImageView.bottomAnchor, constant: 20),
            self.tradeSegment.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.tradeSegment.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
        
    }
}
