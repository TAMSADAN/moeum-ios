//
//  DateButtonView.swift
//  moeum
//
//  Created by 송영모 on 2022/04/05.
//

import UIKit
import Then

class DateButtonView: UIView {
    let tapGesture = UITapGestureRecognizer()
    
    var contentImageString = String()
    var labelString = String()
    
    var contentView = UIView()
    
    var contentImageView = UIImageView(image: UIImage(systemName: "plus"))
        .then {
            $0.tintColor = .black
            $0.contentMode = .scaleAspectFit
        }
    
    var dateLabel = UILabel()
        .then {
            $0.font = .systemFont(ofSize: 15)
            $0.textAlignment = .center
        }
    
    var timeLabel = UILabel()
        .then {
            $0.font = .systemFont(ofSize: 12)
        }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    init(image: String, label: String) {
        super.init(frame: .zero)
        self.contentImageString = image
        self.labelString = label
        self.setup()
    }
    
    func setup() {
        self.addGestureRecognizer(tapGesture)
        
        self.addSubview(self.contentImageView)
        self.contentImageView.image = UIImage(systemName: self.contentImageString)
        self.contentImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentImageView.widthAnchor.constraint(equalToConstant: 20),
            self.contentImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        self.addSubview(self.dateLabel)
        self.dateLabel.text = "2022.04.05(화)"
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dateLabel.leadingAnchor.constraint(equalTo: self.contentImageView.trailingAnchor, constant: 5),
            self.dateLabel.centerYAnchor.constraint(equalTo: self.contentImageView.centerYAnchor),
        ])
        
        self.addSubview(self.timeLabel)
        self.timeLabel.text = "오후 08:30"
        self.timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.timeLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor),
            self.timeLabel.leadingAnchor.constraint(equalTo: self.contentImageView.trailingAnchor, constant: 5),
        ])
    }
}
