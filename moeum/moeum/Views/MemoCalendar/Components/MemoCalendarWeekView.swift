//
//  MemoCalendarWeekView.swift
//  moeum
//
//  Created by 송영모 on 2022/03/29.
//

import UIKit

class MemoCalendarWeekView: UIView {
    
    var weekStackView = UIStackView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(frame: .zero)
        self.configure()
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.configureWeekStackView()
    }
    
    private func configureWeekStackView() {
        self.addSubview(self.weekStackView)
        
        self.weekStackView.distribution = .fillEqually
        
        self.weekStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.weekStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.weekStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.weekStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        let days = ["일", "월", "화", "수", "목", "금", "토"]
        
        for day in days {
            let label = UILabel()
            label.text = day
            label.font = .systemFont(ofSize: 13)
            if day == "일" {
                label.textColor = .systemRed
            } else if day == "토" {
                label.textColor = .systemBlue
            }
            label.textAlignment = .center
            self.weekStackView.addArrangedSubview(label)
        }
    }
}
