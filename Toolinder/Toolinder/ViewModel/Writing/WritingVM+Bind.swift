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
                self?.output.datePickerOpen.accept(false)
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(input.price, input.count)
            .map{ $0 * $1 == 0.0 ? "합계": String($0 * $1) }
            .bind(to: output.sum)
            .disposed(by: disposeBag)
        
        input.item
            .subscribe(onNext: { [weak self] text in
                if text.count > 0 {
                    self?.output.itemHistoryRecordZips.accept(self?.getRecordZips(text: text) ?? [])
//                    self?.output.itemHistoryOpen.accept(true)
                } else {
                    self?.output.itemHistoryRecordZips.accept([])
//                    self?.output.itemHistoryOpen.accept(false)
                }
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(input.item, input.recordZips, input.typeIndex)
            .bind {
                [weak self] item, recordZips, typeIndex in
                let recordZips = recordZips as! [RecordZip]
                let recordZip = recordZips.first(where: { $0.record.item == item })
                
                if typeIndex == 0 {
                    if recordZip != nil {
                        self?.output.itemCaption.accept(("이전에 매수했던 종목입니다.", 1))
                    } else if item != "" {
                        self?.output.itemCaption.accept(("새로운 종목입니다.", 1))
                    } else if item == "" {
                        self?.output.itemCaption.accept(("", 0))
                    }
                } else if typeIndex == 1 {
                    if recordZip != nil {
                        self?.output.itemCaption.accept(("이전에 매수했던 종목입니다.", 1))
                    } else if item != "" {
                        self?.output.itemCaption.accept(("매수 기록이 없습니다.", 2))
                    } else if item == "" {
                        self?.output.itemCaption.accept(("", 0))
                    }
                } else {
                    if recordZip != nil {
                        self?.output.itemCaption.accept(("이전에 매수했던 종목입니다.", 1))
                    } else if item != "" {
                        self?.output.itemCaption.accept(("새로운 종목입니다.", 1))
                    } else if item == "" {
                        self?.output.itemCaption.accept(("", 0))
                    }
                }
                self?.output.recordZip.accept(recordZip ?? RecordZip())
            }
            .disposed(by: disposeBag)
        
//        input.recordZips
//            .bind { s in
//                print(s)
//            }
//            .disposed(by: disposeBag)
        
        Observable.combineLatest(input.count, input.typeIndex)
            .bind { [weak self] count, typeIndex in
                let countSum = self?.output.recordZip.value.getCountSum(date: self?.record.date ?? Date()) ?? -1
//                print("---------------")
//                print(self?.record)
//                print(self?.output.recordZip.value)
                if typeIndex == 1 {
                    if countSum >= count {
                        self?.output.countCaption.accept(("입력 가능한 숫자입니다.", 1))
                    } else {
                        self?.output.countCaption.accept(("최대 입력 숫자인 \(countSum)을 초과했습니다.", 2))
                    }
                }
                
                if count == 0 {
                    self?.output.countCaption.accept(("", 1))
                }
                
                if self?.output.itemCaption.value.1 == 2 {
                    self?.output.countCaption.accept(("오류를 먼저 해결해주세요.", 2))
                }
            }
            .disposed(by: disposeBag)
        
        input.dateButtonTap
            .map { [weak self] in !(self?.output.datePickerOpen.value ?? false) }
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
            .bind { owner, _ in
                if owner.output.itemCaption.value.1 == 1 && owner.output.countCaption.value.1 == 1 {
                    owner.output.pageState.accept(PageState.next)
                }
            }
            .disposed(by: disposeBag)
    }
}
