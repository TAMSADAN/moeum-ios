//
//  ChartViewModel.swift
//  moeum
//
//  Created by 송영모 on 2022/04/13.
//

import Foundation
import RxSwift
import RxCocoa

class ChartViewModel: ViewModel {
    let recordService = RecordService()
    
    var disposeBag = DisposeBag()
    var input = Input()
    var output = Output()
    
    struct Input {
        let recordZips = BehaviorSubject(value: [RecordZip()])
        let tagRecordZips = BehaviorSubject(value: [RecordZip()])
        let itemRecordZips = BehaviorSubject(value: [RecordZip()])
    }
    
    struct Output {
        let recordChartDatas = BehaviorRelay(value: [RecordChartData()])
        let priceSumChartData = BehaviorRelay(value: ([String()], [Double()]))
        let incomeChartData = BehaviorRelay(value: ([Date()], [Double()]))
        let tagBuyPriceSumData = BehaviorRelay(value: ([String()], [Double()]))
    }
    
    init() {
        setBind()
    }
}
