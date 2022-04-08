//
//  CalendarVM+Bind.swift
//  moeum
//
//  Created by 송영모 on 2022/04/08.
//

import Foundation
import RxSwift
import RxCocoa

extension CalendarViewModel {
    func setBind() {
        input.isClickedDatePickerButton
            .bind(to: output.datePickerOpen)
            .disposed(by: disposeBag)
    }
}
