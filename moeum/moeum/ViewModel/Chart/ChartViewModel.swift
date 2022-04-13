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
    let types = ["매수", "매도", "메모"]
    
    let recordService = RecordService()
    
    var disposeBag = DisposeBag()
    var input = Input()
    var output = Output()
    
    var record = Record()
    
    struct Input {
        let recordZips = BehaviorSubject(value: [RecordZip()])
        let tag = PublishSubject<String>()
    }
    
    struct Output {
        let recordChartDatas = BehaviorRelay(value: [RecordChartData()])
        let itemHistoryOpen = BehaviorRelay(value: false)
        let itemHistoryRecordZips = BehaviorRelay(value: [RecordZip()])
        
        let datePickerOpen = BehaviorRelay(value: false)
        let date = BehaviorRelay(value: Date())
        let sum = PublishRelay<String>()
        
        let pageState = PublishRelay<PageState>()
    }
    
    init() {
        self.input.recordZips.onNext(recordService.getRecordZips())
        
        
        input.recordZips
            .subscribe(onNext: { [weak self] recordZips in
                var recordChartDatas: [RecordChartData] = []
                for recordZip in recordZips {
                    recordChartDatas.append(contentsOf: recordZip.getRecordChartDatas())
                }
                self?.output.recordChartDatas.accept(recordChartDatas)
        })
            .disposed(by: disposeBag)
    }
    
    func getThisMonthChartData() -> ([Date], [Double]){
        let dates: [Date] = Date().getDatesOfMonth()
        let recordChartDatas = output.recordChartDatas.value
        
        var chartDatas: [Double] = []
        
        for date in dates {
            var income = 0.0
            recordChartDatas.filter({ $0.date.isEqualDate(date: date) }).forEach({
                income += $0.income
            })
            chartDatas.append(income)
        }
        
        return (dates, chartDatas)
    }
}
