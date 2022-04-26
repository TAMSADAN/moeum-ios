//
//  ListViewModel.swift
//  Toolinder
//
//  Created by 송영모 on 2022/04/25.
//

import Foundation
import RxSwift
import RxCocoa

class ListViewModel: ViewModel {
    let recordService = RecordService()
    let chartDataService = ChartDataService()
    
    var disposeBag = DisposeBag()
    
    var input = Input()
    var output = Output()
    
    struct Input {
        let refresh = BehaviorSubject(value: false)
        let records = BehaviorSubject(value: [Record()])
        let itemRecordZips = BehaviorSubject(value: [RecordZip()])
    }
    
    struct Output {
        let records = BehaviorRelay(value: [Record()])
        let listItemModels = BehaviorRelay(value: [ListItemModel()])
        let holdingAmountChartData = BehaviorRelay(value: ChartData())
        let holdingCount = BehaviorRelay(value: Int())
        let tradeHistoryCount = BehaviorRelay(value: Int())
    }
    
    init() {
        setBind()
        input.records.onNext(recordService.getRecords())
        input.itemRecordZips.onNext(recordService.getRecordZips(tag: false, item: true))
    }
}
