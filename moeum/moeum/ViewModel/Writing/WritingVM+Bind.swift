//
//  WritingVM+Bind.swift
//  moeum
//
//  Created by 송영모 on 2022/04/08.
//

import Foundation
import RxSwift
import RxCocoa

extension WritingViewModel {
    func bind() {
        Observable.combineLatest(input.tag, input.item, input.typeIndex, input.date, input.price, input.count, input.memo)
            .subscribe(onNext: { [weak self] tag, item, typeIndex, date, price, count, memo in
                self?.record.tag = tag
                self?.record.item = item
                self?.record.type = self?.types[typeIndex] ?? "매수"
                self?.record.date = date
                self?.record.price = price
                self?.record.count = count
                self?.record.memo = memo
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(input.price, input.count)
            .map{ $0 * $1 == 0.0 ? "합계": String($0 * $1) }
            .bind(to: output.sum)
            .disposed(by: disposeBag)
        
        input.dateButtonTap
            .map{ [weak self] in !(self?.output.datePickerOpen.value ?? false) }
            .bind(to: output.datePickerOpen)
            .disposed(by: disposeBag)
        
        input.date
            .bind(to: output.date)
            .disposed(by: disposeBag)
    
        input.noBtnFlag
            .withUnretained(self)
            .bind { owner, _ in owner.output.pageState.accept(PageState.back) }
            .disposed(by: disposeBag)
        
        input.yesBtnFlag
            .withUnretained(self)
            .bind { owner, _ in owner.output.pageState.accept(PageState.next) }
            .disposed(by: disposeBag)
    }
}
