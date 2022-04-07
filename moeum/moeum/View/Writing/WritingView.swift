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
    var nameTextField = ImageTextField(image: "centsign.circle", text: "종목명")
    var buyTextField = ImageTextField(image: "wonsign.circle", text: "매수가")
    var sellTextField = ImageTextField(image: "wonsign.circle.fill", text: "매도가")
    var buyCountTextField = ImageTextField(image: "c.circle", text: "매수량")
    var sellCountTextField = ImageTextField(image: "c.circle.fill", text: "매도량")
    var buySumLabel = ImageLabel(image: "equal.circle", label: "합계")
    var sellSumLabel = ImageLabel(image: "equal.circle.fill", label: "합계")
    var incomeLabel = ImageLabel(image: "plusminus.circle.fill", label: "손익")
    var percentLabel = ImageLabel(image: "dollarsign.circle.fill", label: "수익률")
    var memoTextView = ImageTextView(image: "doc.plaintext", text: "메모")
    
    var tradeSegment = UISegmentedControl(items: ["매매", "매수", "매도"])
        .then {
            $0.selectedSegmentIndex = 0
        }
    
    var buyDateButton = DateButtonView(image: "cart.badge.plus", label: "매수일")
    var sellDateButton = DateButtonView(image: "cart.badge.minus", label: "매도일")
    
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
        self.addSubview(self.nameTextField)
        self.addSubview(self.tradeSegment)
        self.addSubview(self.buyDateButton)
        self.addSubview(self.sellDateButton)
        self.addSubview(self.datePicker)
        self.addSubview(self.buyTextField)
        self.addSubview(self.sellTextField)
        self.addSubview(self.buyCountTextField)
        self.addSubview(self.sellCountTextField)
        self.addSubview(self.buySumLabel)
        self.addSubview(self.sellSumLabel)
        self.addSubview(self.incomeLabel)
        self.addSubview(self.percentLabel)
        self.addSubview(self.memoTextView)
        
        self.tagTextField.translatesAutoresizingMaskIntoConstraints = false
        self.nameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.tradeSegment.translatesAutoresizingMaskIntoConstraints = false
        self.buyDateButton.translatesAutoresizingMaskIntoConstraints = false
        self.sellDateButton.translatesAutoresizingMaskIntoConstraints = false
        self.datePicker.translatesAutoresizingMaskIntoConstraints = false
        self.buyTextField.translatesAutoresizingMaskIntoConstraints = false
        self.sellTextField.translatesAutoresizingMaskIntoConstraints = false
        self.buyCountTextField.translatesAutoresizingMaskIntoConstraints = false
        self.sellCountTextField.translatesAutoresizingMaskIntoConstraints = false
        self.buySumLabel.translatesAutoresizingMaskIntoConstraints = false
        self.sellSumLabel.translatesAutoresizingMaskIntoConstraints = false
        self.incomeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.percentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.memoTextView.translatesAutoresizingMaskIntoConstraints = false
        
        self.datePickerHeightConstraint = self.datePicker.heightAnchor.constraint(equalToConstant: 216)
        self.hideDatePicker()
        
        NSLayoutConstraint.activate([
            self.tagTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            self.tagTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.tagTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            self.tagTextField.heightAnchor.constraint(equalToConstant: 20),
            
            self.nameTextField.topAnchor.constraint(equalTo: self.tagTextField.bottomAnchor, constant: 15),
            self.nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            self.nameTextField.heightAnchor.constraint(equalToConstant: 20),
            
            self.tradeSegment.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: 15),
            self.tradeSegment.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.tradeSegment.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            self.buyDateButton.topAnchor.constraint(equalTo: self.tradeSegment.bottomAnchor, constant: 15),
            self.buyDateButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.buyDateButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5, constant: -10),
            self.buyDateButton.bottomAnchor.constraint(equalTo: self.buyDateButton.timeLabel.bottomAnchor),
            
            self.sellDateButton.topAnchor.constraint(equalTo: self.tradeSegment.bottomAnchor, constant: 15),
            self.sellDateButton.leadingAnchor.constraint(equalTo: self.buyDateButton.trailingAnchor, constant: 10),
            self.sellDateButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.sellDateButton.bottomAnchor.constraint(equalTo: self.sellDateButton.timeLabel.bottomAnchor),
            
            self.datePicker.topAnchor.constraint(equalTo: self.sellDateButton.bottomAnchor, constant: 10),
            self.datePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.datePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            self.datePickerHeightConstraint,
            
            self.buyTextField.topAnchor.constraint(equalTo: self.datePicker.bottomAnchor, constant: 10),
            self.buyTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.buyTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5, constant: -10),
            self.buyTextField.heightAnchor.constraint(equalToConstant: 20),
            
            self.sellTextField.topAnchor.constraint(equalTo: self.datePicker.bottomAnchor, constant: 10),
            self.sellTextField.leadingAnchor.constraint(equalTo: self.buyTextField.trailingAnchor, constant: 10),
            self.sellTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.sellTextField.heightAnchor.constraint(equalToConstant: 20),
            
            self.buyCountTextField.topAnchor.constraint(equalTo: self.buyTextField.bottomAnchor, constant: 15),
            self.buyCountTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.buyCountTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5 ,constant: -10),
            self.buyCountTextField.heightAnchor.constraint(equalToConstant: 20),
            
            self.sellCountTextField.topAnchor.constraint(equalTo: self.sellTextField.bottomAnchor, constant: 15),
            self.sellCountTextField.leadingAnchor.constraint(equalTo: self.buyCountTextField.trailingAnchor, constant: 10),
            self.sellCountTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.sellCountTextField.heightAnchor.constraint(equalToConstant: 20),
            
            self.buySumLabel.topAnchor.constraint(equalTo: self.buyCountTextField.bottomAnchor, constant: 15),
            self.buySumLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.buySumLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5, constant: -10),
            self.buySumLabel.heightAnchor.constraint(equalToConstant: 20),
            
            self.sellSumLabel.topAnchor.constraint(equalTo: self.sellCountTextField.bottomAnchor, constant: 15),
            self.sellSumLabel.leadingAnchor.constraint(equalTo: self.buySumLabel.trailingAnchor, constant: 10),
            self.sellSumLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.sellSumLabel.heightAnchor.constraint(equalToConstant: 20),
            
            self.incomeLabel.topAnchor.constraint(equalTo: self.buySumLabel.bottomAnchor, constant: 15),
            self.incomeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.incomeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.incomeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            self.percentLabel.topAnchor.constraint(equalTo: self.incomeLabel.bottomAnchor, constant: 15),
            self.percentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.percentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.percentLabel.heightAnchor.constraint(equalToConstant: 20),
            
            self.memoTextView.topAnchor.constraint(equalTo: self.percentLabel.bottomAnchor, constant: 15),
            self.memoTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.memoTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            self.memoTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
