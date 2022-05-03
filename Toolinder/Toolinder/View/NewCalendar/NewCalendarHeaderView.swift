//
//  NewCalendarHeaderView.swift
//  Toolinder
//
//  Created by 송영모 on 2022/05/03.
//

import UIKit
import Then

class NewCalendarHeaderView: UIView {
    var headerBackgroundView = UIView().then {
        $0.backgroundColor = Const.Color.white
    }
    
    var dateLabel = UILabel().then {
        $0.font = Const.Font.title1
        $0.text = "2022.4"
//        $0.font = Const.Font.headline
    }
    
    var conatinerView = UIView()
    
    var datePicker = UIDatePicker().then {
            $0.timeZone = NSTimeZone.local
            $0.locale = Locale(identifier: "ko_KR")
            $0.minuteInterval = 10
            $0.datePickerMode = .date
            $0.backgroundColor = .white
            if #available(iOS 13.4, *) {
                $0.preferredDatePickerStyle = .wheels
            }
        }
    
    var headerBackgroundViewHeightConstraint = NSLayoutConstraint()
    var datePickerHeightConstraint = NSLayoutConstraint()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    func setView() {
        
//        addSubview(headerBackgroundView)
        
        addSubview(conatinerView)
        conatinerView.addSubview(headerBackgroundView)
        addSubview(datePicker)
        addSubview(dateLabel)
        
        conatinerView.translatesAutoresizingMaskIntoConstraints = false
        headerBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerBackgroundViewHeightConstraint = headerBackgroundView.heightAnchor.constraint(equalToConstant: Const.Size.calendarHeaderMinHeight)
        datePickerHeightConstraint = datePicker.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            headerBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            headerBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            headerBackgroundViewHeightConstraint,
            
            datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: headerBackgroundView.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: headerBackgroundView.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: headerBackgroundView.bottomAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
        ])
    }
}

extension NewCalendarHeaderView {
    func show() {
        headerBackgroundViewHeightConstraint.constant = Const.Size.calendarHeaderMaxHeight
        UIView.animate(withDuration: 0.25, animations: {
            self.headerBackgroundViewHeightConstraint.isActive = true
            self.datePicker.alpha = 1
            self.conatinerView.layoutIfNeeded()
        })
    }
    
    func hide() {
        headerBackgroundViewHeightConstraint.constant = Const.Size.calendarHeaderMinHeight
        UIView.animate(withDuration: 0.25, animations: {
            self.headerBackgroundViewHeightConstraint.isActive = true
            self.datePicker.alpha = 0
            self.conatinerView.layoutIfNeeded()
        })
    }
}
