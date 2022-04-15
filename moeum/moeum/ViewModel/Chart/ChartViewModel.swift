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
    }
    
    init() {
        input.recordZips.onNext(recordService.getRecordZips(tag: true, item: true))
        input.tagRecordZips.onNext(recordService.getRecordZips(tag: true, item: false))
        input.itemRecordZips.onNext(recordService.getRecordZips(tag: false, item: true))
        
        input.itemRecordZips
            .bind { [weak self] recordZips in
                self?.output.incomeChartData.accept(self?.getIncomeBarChartData(date: Date(), recordZips: recordZips) ?? ([Date()], [Double()]))
                self?.output.priceSumChartData.accept(self?.getBuyPriceSumPieChartData(date: Date(), recordZips: recordZips) ?? ([String()], [Double()]))
            }
            .disposed(by: disposeBag)
//            .subscribe(onNext: {
//                [weak self] recordZips in
//                self?.output.incomeChartData.accept(self?.getIncomeBarChartData(date: Date(), recordZips: recordZips) ?? ([Date(), [Double()]]))
//            })
        
//        input.recordZips
//            .subscribe(onNext: { [weak self] recordZips in
//                var recordChartDatas: [RecordChartData] = []
//                for recordZip in recordZips {
//                    recordChartDatas.append(contentsOf: recordZip.getRecordChartDatas())
//                }
//                self?.output.recordChartDatas.accept(recordChartDatas)
//        })
//            .disposed(by: disposeBag)
    }
}
