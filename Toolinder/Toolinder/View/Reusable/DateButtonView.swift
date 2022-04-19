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
        addGestureRecognizer(tapGesture)
        
        addSubview(contentImageView)
        contentImageView.image = UIImage(systemName: contentImageString)
        contentImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentImageView.topAnchor.constraint(equalTo: topAnchor),
            contentImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentImageView.widthAnchor.constraint(equalToConstant: 20),
            contentImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        addSubview(dateLabel)
        dateLabel.text = labelString
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentImageView.trailingAnchor, constant: 5),
            dateLabel.centerYAnchor.constraint(equalTo: contentImageView.centerYAnchor),
        ])
        
        addSubview(timeLabel)
        timeLabel.text = ""
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: contentImageView.trailingAnchor, constant: 5),
        ])
    }
}
