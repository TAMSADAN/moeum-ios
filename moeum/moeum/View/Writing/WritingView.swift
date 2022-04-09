//
//  WritingView.swift
//  moeum
//
//  Created by 송영모 on 2022/04/04.
//

import UIKit
import Then

class WritingView: UIView {
    
    var tagTextField = ImageTextField(image: "tag.circle", text: "태그")
    var itemTextField = ImageTextField(image: "centsign.circle", text: "종목명")
    var priceTextField = ImageTextField(image: "wonsign.circle", text: "매수가")
    var countTextField = ImageTextField(image: "c.circle", text: "매수량")
    var sumLabel = ImageLabel(image: "equal.circle", label: "합계")
    var incomeLabel = ImageLabel(image: "plusminus.circle.fill", label: "손익")
    var percentLabel = ImageLabel(image: "dollarsign.circle.fill", label: "수익률")
    var memoTextView = ImageTextView(image: "doc.plaintext", text: "메모")
    
    var tradeSegment = UISegmentedControl(items: ["매매", "매수", "매도"])
        .then {
            $0.selectedSegmentIndex = 0
        }
    
    var dateButton = DateButtonView(image: "cart.badge.plus", label: "매수일")
    
    var datePicker = UIDatePicker()
        .then {
            $0.timeZone = NSTimeZone.local
            $0.locale = Locale(identifier: "ko_KR")
            $0.minuteInterval = 10
            if #available(iOS 13.4, *) {
                $0.preferredDatePickerStyle = .wheels
            } else {
                
            }
        }
    
    var datePickerHeightConstraint = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
}

// Animation
extension WritingView {
    func showDatePicker(date: Date) {
        self.datePickerHeightConstraint.constant = 216
        UIView.animate(withDuration: 0.25,delay: 0, options: .curveLinear,animations: {
            self.datePickerHeightConstraint.isActive = true
            self.datePicker.setDate(date, animated: true)
            self.layoutIfNeeded()
        })
    }
    
    func hideDatePicker() {
        self.datePickerHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.25,delay: 0, options: .curveLinear,animations: {
            self.datePickerHeightConstraint.isActive = true
            self.layoutIfNeeded()
        })
    }
}

extension WritingView {
    func setup() {
        self.addSubview(self.tagTextField)
        self.addSubview(self.itemTextField)
        self.addSubview(self.tradeSegment)
        self.addSubview(self.dateButton)
        self.addSubview(self.datePicker)
        self.addSubview(self.priceTextField)
        self.addSubview(self.countTextField)
        self.addSubview(self.sumLabel)
        self.addSubview(self.incomeLabel)
        self.addSubview(self.percentLabel)
        self.addSubview(self.memoTextView)
        
        self.tagTextField.translatesAutoresizingMaskIntoConstraints = false
        self.itemTextField.translatesAutoresizingMaskIntoConstraints = false
        self.tradeSegment.translatesAutoresizingMaskIntoConstraints = false
        self.dateButton.translatesAutoresizingMaskIntoConstraints = false
        self.datePicker.translatesAutoresizingMaskIntoConstraints = false
        self.priceTextField.translatesAutoresizingMaskIntoConstraints = false
        self.countTextField.translatesAutoresizingMaskIntoConstraints = false
        self.sumLabel.translatesAutoresizingMaskIntoConstraints = false
        self.incomeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.percentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.memoTextView.translatesAutoresizingMaskIntoConstraints = false
        
        self.datePickerHeightConstraint = self.datePicker.heightAnchor.constraint(equalToConstant: 216)
        self.hideDatePicker()
        
        NSLayoutConstraint.activate([
            tagTextField.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            tagTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tagTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            tagTextField.heightAnchor.constraint(equalToConstant: 20),
            
            itemTextField.topAnchor.constraint(equalTo: self.tagTextField.bottomAnchor, constant: 15),
            itemTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            itemTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            itemTextField.heightAnchor.constraint(equalToConstant: 20),
            
            tradeSegment.topAnchor.constraint(equalTo: itemTextField.bottomAnchor, constant: 15),
            tradeSegment.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tradeSegment.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            dateButton.topAnchor.constraint(equalTo: tradeSegment.bottomAnchor, constant: 15),
            dateButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dateButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -10),
            dateButton.bottomAnchor.constraint(equalTo: dateButton.timeLabel.bottomAnchor),
            
            datePicker.topAnchor.constraint(equalTo: dateButton.bottomAnchor, constant: 15),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            datePickerHeightConstraint,
            
            priceTextField.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 0),
            priceTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            priceTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            priceTextField.heightAnchor.constraint(equalToConstant: 20),
            
            countTextField.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 15),
            countTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            countTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            countTextField.heightAnchor.constraint(equalToConstant: 20),
            
            sumLabel.topAnchor.constraint(equalTo: countTextField.bottomAnchor, constant: 15),
            sumLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            sumLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -10),
            sumLabel.heightAnchor.constraint(equalToConstant: 20),
            
            incomeLabel.topAnchor.constraint(equalTo: sumLabel.bottomAnchor, constant: 15),
            incomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            incomeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            incomeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            percentLabel.topAnchor.constraint(equalTo: incomeLabel.bottomAnchor, constant: 15),
            percentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            percentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            percentLabel.heightAnchor.constraint(equalToConstant: 20),
            
            memoTextView.topAnchor.constraint(equalTo: percentLabel.bottomAnchor, constant: 15),
            memoTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            memoTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            memoTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
