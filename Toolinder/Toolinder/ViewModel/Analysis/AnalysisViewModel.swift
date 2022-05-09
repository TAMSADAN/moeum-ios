//
//  AnalysisViewModel.swift
//  Toolinder
//
//  Created by 송영모 on 2022/04/27.
//

import Foundation
import RxSwift
import RxCocoa

class AnalysisViewModel: ViewModel {
    let recordService = RecordService()
    let chartDataService = ChartDataService()
    let chartService = ChartService()
    let recordHelperService = RecordZipService()
    let recordZipTableViewCellModelService = RecordZipTableViewCellModelService()
    
    var disposeBag = DisposeBag()
    
    var input = Input()
    var output = Output()
    
    struct Input {
        let refresh = BehaviorSubject(value: false)
        let records = BehaviorSubject(value: [Record()])
        let itemRecordZips = BehaviorSubject(value: [RecordZip()])
        
        let tradeBarChartViewTypeOption = BehaviorSubject(value: 0)
        let tradeBarChartViewPeriodOption = BehaviorSubject(value: 0)
    }
    
    struct Output {
        let tradeChartZips = BehaviorRelay(value: [
            TradeChartZip(),
        ])
        let recordZips = BehaviorRelay(value: [RecordZip()])
        let recordZipTableViewCellModels = BehaviorRelay(value: [RecordZipTableViewCellModel()])
        let tradeBarChartViewTypeOption = BehaviorRelay(value: 0)
        let tradeBarChartViewPeriodOption = BehaviorRelay(value: 0)
    }
    
    init() {
        setBind()
    }
}

extension AnalysisViewModel {
    func refresh() {
        setBind()
    }
    
    func setBind() {
        output.recordZips.accept(recordHelperService.getRecordZips(Unit.item))
        output.recordZipTableViewCellModels.accept(recordZipTableViewCellModelService.getModels())
        
        input.tradeBarChartViewTypeOption
            .bind(to: output.tradeBarChartViewTypeOption)
            .disposed(by: disposeBag)
        
        input.tradeBarChartViewPeriodOption
            .withUnretained(self)
            .bind { owner, option in
                if option == 0 {
                    owner.output.tradeChartZips.accept(owner.chartService.getTradeChartZips(period: Period.day))
                } else if option == 1 {
                    owner.output.tradeChartZips.accept(owner.chartService.getTradeChartZips(period: Period.week))
                } else if option == 2 {
                    owner.output.tradeChartZips.accept(owner.chartService.getTradeChartZips(period: Period.month))
                }
            }
            .disposed(by: disposeBag)
    }
}

extension AnalysisViewModel {
    
}
