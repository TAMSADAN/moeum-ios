//
//  CalendarVC_Logic.swift
//  moeum
//
//  Created by 송영모 on 2022/04/07.
//

extension CalendarViewController {
    func goToWritingVC() {
        let writingVC = WritingViewController()
        writingVC.modalPresentationStyle = .fullScreen
        self.present(writingVC, animated: true)
    }
}
