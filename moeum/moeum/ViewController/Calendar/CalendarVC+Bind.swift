//
//  CalendarVC+Bind.swift
//  moeum
//
//  Created by 송영모 on 2022/04/07.
//

extension CalendarViewController {
    func binding() {
        writingButton.rx.tap
            .bind { [weak self] in self?.goToWritingVC() }
            .disposed(by: disposeBag)
    }
}
