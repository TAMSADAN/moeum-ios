//
//  CalendarVC_Logic.swift
//  moeum
//
//  Created by 송영모 on 2022/04/07.
//

import UIKit

extension CalendarViewController {
//    func showDatePicker() {
//        datePickerHeightConstraint.constant = 216
//        UIView.animate(withDuration: 0.25,delay: 0, options: .curveLinear,animations: {
//            self.datePickerHeightConstraint.isActive = true
//            self.view.layoutIfNeeded()
//        })
//    }
//    
//    func hideDatePicker() {
//        datePickerHeightConstraint.constant = 0
//        UIView.animate(withDuration: 0.25,delay: 0, options: .curveLinear,animations: {
//            self.datePickerHeightConstraint.isActive = true
//            self.view.layoutIfNeeded()
//        })
//    }
    
    func goToWritingVC() {
        let writingVC = WritingViewController()
        writingVC.modalPresentationStyle = .fullScreen
        self.present(writingVC, animated: true)
    }
    
    
}
