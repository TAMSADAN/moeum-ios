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
            $0.font = .systemFont(ofSize: 25, weight: .bold)
        }
    
    var pickerBtn = UIButton()
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
    var datePickerTopConstraint = NSLayoutConstraint()
    var datePickerBottomConstraint = NSLayoutConstraint()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
}

extension CalendarHeaderView {
    func setView() {
        addSubview(pickerBtn)
        addSubview(datePickerBackgroundView)
        addSubview(datePicker)
        addSubview(monthLabel)
        
        datePicker.backgroundColor = .red
        
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        pickerBtn.translatesAutoresizingMaskIntoConstraints = false
        datePickerBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false

        datePickerHeightConstraint = datePicker.bottomAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 0)
        datePickerTopConstraint = datePicker.topAnchor.constraint(equalTo: monthLabel.bottomAnchor)
        datePickerBottomConstraint = datePicker.bottomAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 0)
        
        NSLayoutConstraint.activate([
            monthLabel.topAnchor.constraint(equalTo: topAnchor),
            monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            pickerBtn.leadingAnchor.constraint(equalTo: monthLabel.trailingAnchor, constant: 5),
            pickerBtn.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor),
            pickerBtn.widthAnchor.constraint(equalToConstant: 20),
            pickerBtn.heightAnchor.constraint(equalToConstant: 20),
            
            datePickerBackgroundView.topAnchor.constraint(equalTo: datePicker.topAnchor),
            datePickerBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            datePickerBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            datePickerBackgroundView.bottomAnchor.constraint(equalTo: datePicker.bottomAnchor),
            
            datePickerTopConstraint,
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            datePickerBottomConstraint,
            
            
//            datePicker.topAnchor.constraint(equalTo: monthLabel.bottomAnchor),
//            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            datePickerHeightConstraint,
        ])
    }
}


extension CalendarHeaderView {
    func showDatePicker() {
        datePickerBottomConstraint.constant = 219
        UIView.animate(withDuration: 0.25,delay: 0, options: .curveLinear,animations: {
            self.datePickerHeightConstraint.isActive = true
            self.layoutIfNeeded()
        })
    }

    func hideDatePicker() {
        datePickerBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.25,delay: 0, options: .curveLinear,animations: {
            self.datePickerHeightConstraint.isActive = true
            self.layoutIfNeeded()
        })
    }
}
