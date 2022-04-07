//
//  WritingViewModel.swift
//  moeum
//
//  Created by 송영모 on 2022/04/06.
//

import Foundation
import RxSwift
import RxCocoa

class WritingViewModel: ViewModel {
    
    var disposeBag = DisposeBag()
    var input = Input()
    var output = Output()
    
    struct Input {
        let tagName = PublishSubject<String>()
        let itemName = PublishSubject<String>()
        let isClickedBuyDateButton = BehaviorRelay(value: false)
        let isClickedSellDateButton = BehaviorRelay(value: false)
        let date = PublishSubject<Date>()
        let buyPrice = PublishSubject<String>()
        let sellPrice = PublishSubject<String>()
        let buyCount = PublishSubject<String>()
        let sellCount = PublishSubject<String>()
        let memo = PublishSubject<String>()
        let noBtnFlag = PublishSubject<Bool>()
        let yesBtnFlag = PublishSubject<Bool>()
    }
    
    struct Output {
        let datePickerOpen = PublishRelay<Int>()
        let buyDate = BehaviorRelay(value: Date(timeIntervalSince1970: 0))
        let sellDate = BehaviorRelay(value: Date(timeIntervalSince1970: 0))
        let buySum = PublishRelay<String>()
        let sellSum = PublishRelay<String>()
        let income = PublishRelay<Double>()
        let precent = PublishRelay<Double>()
        let pageState = PublishRelay<PageState>()
    }
    
    init() {
        self.bind()
    }
}

extension WritingViewModel {
    func clickBuyDateButton() {
        let buyDateButtonFlag = self.input.isClickedBuyDateButton.value
        
        self.input.isClickedBuyDateButton.accept(!buyDateButtonFlag)
        self.input.isClickedSellDateButton.accept(false)
    }
    
    func clickSellDateButton() {
        let sellDateButtonFlag = self.input.isClickedSellDateButton.value
        
        self.input.isClickedBuyDateButton.accept(false)
        self.input.isClickedSellDateButton.accept(!sellDateButtonFlag)
    }
    
    func getDateStringFromDate(date: Date) -> String {
        let weekDays = ["일", "월", "화", "수", "목", "금", "토"]
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .weekday], from: date)
        
        var dateString = String(format: "%d.%02d.%02d (%@)", components.year!, components.month!, components.day!, weekDays[components.weekday! - 1])
        
        return dateString
        
    }
    
    func getTimeStringFromDate(date: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        
        var timeString = String(format: "%02d:%02d", components.hour!, components.minute!)
        
        return timeString
    }
}

extension WritingViewModel {
    func bind() {
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
            .map { flag, date in
                if flag {
                    return date
                } else {
                    return Date(timeIntervalSince1970: 0)
                }
            }
            .bind(to: self.output.buyDate)
            .disposed(by: self.disposeBag)
        
        Observable.combineLatest(input.isClickedSellDateButton, input.date)
            .map { flag, date in
                if flag {
                    return date
                } else {
                    return Date(timeIntervalSince1970: 0)
                }
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
        
        Observable.combineLatest(input.noBtnFlag, input.yesBtnFlag)
            .map { no, yes in
                if no {
                    return PageState.back
                } else if yes {
                    return PageState.next
                } else {
                    return PageState.defult
                }
                print("변화감지")
            }
            .bind(to: self.output.pageState)
            .disposed(by: self.disposeBag)
        
        input.noBtnFlag
            .withUnretained(self)
            .bind { owner, _ in
                owner.output.pageState.accept(PageState.back)
                print("noBtnFlag 바인딩 댐")
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(input.tagName, input.itemName, input.buyPrice, input.sellPrice, input.buyCount, input.sellCount, input.memo)
            .map { _ in return 0 }
            .bind(to: self.output.datePickerOpen)
            .disposed(by: self.disposeBag)
    }
}
