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
        Observable.combineLatest(input.tagName, input.itemName, input.buyPrice, input.sellPrice, input.buyCount, input.sellCount, input.memo)
            .subscribe(onNext: { [weak self] tN, iN, bP, sP, bC, sC, mm in
                self?.record.tagName = tN
                self?.record.itemName = iN
                self?.record.buyPrice = bP
                self?.record.sellPrice = sP
                self?.record.buyCount = bC
                self?.record.sellCount = sC
                self?.record.memo = mm
                self?.output.datePickerOpen.accept(0)
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(output.buyDate, output.sellDate)
            .subscribe(onNext: { [weak self] bD, sD in
                self?.record.buyDate = bD
                self?.record.sellDate = sD
            })
            .disposed(by: disposeBag)
        
        
        Observable.combineLatest(input.buyPrice, input.buyCount)
            .map { price, count in
                if !(price.isEmpty) && !(count.isEmpty) {
                    return String((Double(price) ?? 0) * (Double(count) ?? 0))
                }
                return "합계"
            }
            .bind(to: self.output.buySum)
            .disposed(by: self.disposeBag)
        
        Observable.combineLatest(input.sellPrice, input.sellCount)
            .map { price, count in
                if !(price.isEmpty) && !(count.isEmpty) {
                    return String((Double(price) ?? 0) * (Double(count) ?? 0))
                }
                return "합계"
            }
            .bind(to: self.output.sellSum)
            .disposed(by: self.disposeBag)
        
        Observable.combineLatest(input.isClickedBuyDateButton, input.date)
            .filter { flag, map in
                flag == true
            }
            .map {
                flag, date in
                return date
            }
            .bind(to: self.output.buyDate)
            .disposed(by: self.disposeBag)
        
        Observable.combineLatest(input.isClickedSellDateButton, input.date)
            .filter { flag, map in
                flag == true
            }
            .map {
                flag, date in
                return date
            }
            .bind(to: self.output.sellDate)
            .disposed(by: self.disposeBag)
        
        Observable.combineLatest(input.isClickedBuyDateButton, input.isClickedSellDateButton)
            .map { flag1, flag2 in
                if flag1 && !flag2 {
                    return 1
                } else if !flag1 && flag2 {
                    return 2
                } else {
                    return 0
                }
            }
            .bind(to: self.output.datePickerOpen)
            .disposed(by: self.disposeBag)
        
        input.noBtnFlag
            .withUnretained(self)
            .bind { owner, _ in owner.output.pageState.accept(PageState.back) }
            .disposed(by: disposeBag)
        
        input.yesBtnFlag
            .withUnretained(self)
            .bind { owner, _ in owner.output.pageState.accept(PageState.next) }
            .disposed(by: disposeBag)
        
        //        Observable.combineLatest(input.noBtnFlag, input.yesBtnFlag)
        //            .map { no, yes in
        //                print(no, yes)
        //                if no {
        //                    return PageState.back
        //                } else if yes {
        //                    return PageState.next
        //                } else {
        //                    return PageState.defult
        //                }
        //            }
        //            .bind(to: self.output.pageState)
        //            .disposed(by: self.disposeBag)
        
        //        input.noBtnFlag
        //            .withUnretained(self)
        //            .bind { owner, _ in owner.output.pageState.accept(PageState.back) }
        //            .disposed(by: disposeBag)
        //
        //        input.yesBtnFlag
        //            .withUnretained(self)
        //            .bind { owner, _ in owner.output.pageState.accept(PageState.next) }
        //            .disposed(by: disposeBag)
    }
}
