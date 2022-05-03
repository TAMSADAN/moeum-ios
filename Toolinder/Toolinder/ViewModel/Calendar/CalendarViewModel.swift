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
        let refresh = BehaviorSubject(value: false)
        let records = BehaviorSubject(value: [Record()])
        let isMonthLabelClicked = BehaviorSubject(value: false)
        let datePickerDate = BehaviorSubject(value: Date())
        let selectedCellIndexPath = BehaviorSubject(value: IndexPath())
        let calendarSelectedCellData = BehaviorSubject(value: (IndexPath(), Date(), [Record()]))
    }
    
    struct Output {
        let records = PublishRelay<[Record]>()
        let monthLabelText = BehaviorRelay(value: "")
        let datePickerOpen = PublishRelay<Bool>()
        let calendarDates = PublishRelay<[Date]>()
        let calendarCellDatas = BehaviorRelay(value: [(Date(), [Record()])])
        let bottomSheetRecords = BehaviorRelay(value: [Record()])
        let bottomSheetDate = BehaviorRelay(value: Date())
    }
    
    init() {
        setBind()
        input.records.onNext(recordService.getRecords())
        output.calendarDates.accept(try! input.datePickerDate.value().getDatesOfMonth())
    }
}
