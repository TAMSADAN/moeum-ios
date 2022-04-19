//
//  CalendarVC_Logic.swift
//  moeum
//
//  Created by 송영모 on 2022/04/07.
//

import UIKit

extension CalendarViewController {
    func showHeader() {
        headerHeightConstraint.constant = 250
        UIView.animate(withDuration: 0.25,delay: 0, options: .curveLinear,animations: {
            self.headerHeightConstraint.isActive = true
            self.view.layoutIfNeeded()
        })
    }
    
    func hideHeader() {
        headerHeightConstraint.constant = 20
        UIView.animate(withDuration: 0.25,delay: 0, options: .curveLinear,animations: {
            self.headerHeightConstraint.isActive = true
            self.view.layoutIfNeeded()
        })
    }
    
    func goToWritingVC() {
        let writingVC = WritingViewController()
        writingVC.modalPresentationStyle = .fullScreen
        writingVC.writingView.datePicker.date = viewModel.output.cellDate.value
        self.present(writingVC, animated: true)
    }
    
    
}
