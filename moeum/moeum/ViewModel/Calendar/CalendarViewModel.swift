//
//  CalendarViewModel.swift
//  moeum
//
//  Created by 송영모 on 2022/04/08.
//

import Foundation
import RxSwift
import RxCocoa

class CalendarViewModel: ViewModel {
    let recordService = RecordService()
    
    var disposeBag = DisposeBag()
    
    var input = Input()
    var output = Output()
    
    struct Input {
        let nowDate = BehaviorSubject<Date>(value: Date())
        let isClickedDatePickerButton = BehaviorRelay(value: false)
        let records = PublishRelay<[Record]>()
        let dates = PublishRelay<[Date]>()
    }
    
    struct Output {
        
        let datePickerOpen = PublishRelay<Bool>()
        let dateLabel = PublishRelay<String>()
        
        let cellDatas = PublishRelay<(Date, [Record])>()

        let buyDate = BehaviorRelay(value: Date(timeIntervalSince1970: 0))
        let sellDate = BehaviorRelay(value: Date(timeIntervalSince1970: 0))
        let buySum = PublishRelay<String>()
        let sellSum = PublishRelay<String>()
        let income = PublishRelay<Double>()
        let precent = PublishRelay<Double>()
        let pageState = PublishRelay<PageState>()
    }
    
    init() {
        setBind()
        input.records.accept(recordService.getAllRecord())
        input.dates.accept(getDatesOfMonth(date: try! input.nowDate.value()))
    }
}
