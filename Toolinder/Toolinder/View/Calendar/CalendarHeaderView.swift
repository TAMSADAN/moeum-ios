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
    
    var datePickerBackgroundView = UIView()
        .then {
            $0.backgroundColor = .white
        }
    
    var datePicker = UIDatePicker()
        .then {
            $0.timeZone = NSTimeZone.local
            $0.locale = Locale(identifier: "ko_KR")
            $0.minuteInterval = 10
            $0.datePickerMode = .date
            $0.backgroundColor = .white
            if #available(iOS 13.4, *) {
                $0.preferredDatePickerStyle = .wheels
            } else {

            }
        }
    
    var datePickerHeightConstraint = NSLayoutConstraint()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
}

// animation
extension CalendarHeaderView {
    func showDatePicker() {
        datePickerHeightConstraint.constant = 216
        UIView.animate(withDuration: 0.25,delay: 0, options: .curveLinear,animations: {
            self.datePickerHeightConstraint.isActive = true
            self.layoutIfNeeded()
        })
    }

    func hideDatePicker() {
        datePickerHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.25,delay: 0, options: .curveLinear,animations: {
            self.datePickerHeightConstraint.isActive = true
            self.layoutIfNeeded()
        })
    }
}

// setView
extension CalendarHeaderView {
    func setView() {
        addSubview(monthLabel)
        addSubview(pickerButton)
        addSubview(datePickerBackgroundView)
        addSubview(datePicker)
        
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        pickerButton.translatesAutoresizingMaskIntoConstraints = false
        datePickerBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false

        datePickerHeightConstraint = datePicker.bottomAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 0)
        
        NSLayoutConstraint.activate([
            monthLabel.topAnchor.constraint(equalTo: topAnchor),
            monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            pickerButton.leadingAnchor.constraint(equalTo: monthLabel.trailingAnchor, constant: 5),
            pickerButton.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor),
            pickerButton.widthAnchor.constraint(equalToConstant: 20),
            pickerButton.heightAnchor.constraint(equalToConstant: 20),
            
            datePickerBackgroundView.topAnchor.constraint(equalTo: datePicker.topAnchor),
            datePickerBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            datePickerBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            datePickerBackgroundView.bottomAnchor.constraint(equalTo: datePicker.bottomAnchor),
            
            datePicker.topAnchor.constraint(equalTo: monthLabel.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            datePickerHeightConstraint,
        ])
    }
}
