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
        let isClickedDatePickerButton = BehaviorSubject(value: false)
        let cellData = PublishSubject<(Date, [Record])>()
        let indexPath = BehaviorRelay(value: IndexPath())
    }
    
    struct Output {
        let records = PublishRelay<[Record]>()
        let dates = PublishRelay<[Date]>()
        let datePickerOpen = PublishRelay<Bool>()
        let dateLabel = BehaviorRelay(value: "")
        let cellDatas = BehaviorRelay(value: [(Date(), [Record()])])
    }
    
    init() {
        setBind()
        output.records.accept(recordService.getAllRecord())
        output.dates.accept(getDatesOfMonth(date: try! input.nowDate.value()))
    }
}
