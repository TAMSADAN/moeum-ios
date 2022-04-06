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
    
    var input = Input()
    var output = Output()
    
    struct Input {
        let tagName = PublishSubject<String>()
        let itemName = PublishSubject<String>()
        let isClickedBuyDateButton = PublishSubject<Bool>()
        let isClickedSellDateButton = PublishSubject<Bool>()
        let date = PublishSubject<Date>()
        let buyPrice = PublishSubject<String>()
        let sellPrice = PublishSubject<String>()
        let buyCount = PublishSubject<String>()
        let sellCount = PublishSubject<String>()
        let memo = PublishSubject<String>()
    }
    
    struct Output {
        let buySum = PublishRelay<Double>()
        let sellSum = PublishRelay<Double>()
        let income = PublishRelay<Double>()
        let precent = PublishRelay<Double>()
    }
    
    init() {
        self.bind()
    }
}

extension WritingViewModel {
    func bind() {

    }
}
