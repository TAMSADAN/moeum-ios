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
    
    let recordService = RecordService()
    
    var disposeBag = DisposeBag()
    var input = Input()
    var output = Output()
    
    var record = Record()
    
    struct Input {
        let tag = PublishSubject<String>()
        let item = PublishSubject<String>()
        let typeButtonTap = PublishSubject<Void>()
        let dateButtonTap = PublishSubject<Void>()
        let date = PublishSubject<Date>()
        let price = PublishSubject<Double>()
        let count = PublishSubject<Double>()
        let memo = PublishSubject<String>()
        let noBtnFlag = PublishSubject<Bool>()
        let yesBtnFlag = PublishSubject<Bool>()
    }
    
    struct Output {
        let datePickerOpen = BehaviorRelay(value: false)
        let date = BehaviorRelay(value: Date())
        let sum = PublishRelay<String>()
        
        let pageState = PublishRelay<PageState>()
    }
    
    init() {
        self.bind()
    }
}
