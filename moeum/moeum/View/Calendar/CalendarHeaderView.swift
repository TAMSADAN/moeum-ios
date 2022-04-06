//
//  CalendarHeaderView.swift
//  moeum
//
//  Created by 송영모 on 2022/04/04.
//

import UIKit
import Then

class CalendarHeaderView: UIView {
    var monthLabel = UILabel()
        .then {
            $0.text = "2022.3"
            $0.font = .systemFont(ofSize: 20, weight: .bold)
        }
    
    var pickerButton = UIButton()
        .then {
            $0.setBackgroundImage(UIImage(systemName: "chevron.down"), for: .normal)
            $0.tintColor = .black
        }
    
    var pickerView = UIDatePicker()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    func setup() {
        self.addSubview(self.monthLabel)
        self.monthLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.monthLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.monthLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.monthLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        self.addSubview(self.pickerButton)
        self.pickerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.pickerButton.leadingAnchor.constraint(equalTo: self.monthLabel.trailingAnchor, constant: 5),
            self.pickerButton.centerYAnchor.constraint(equalTo: self.monthLabel.centerYAnchor),
            self.pickerButton.widthAnchor.constraint(equalToConstant: 20),
            self.pickerButton.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
