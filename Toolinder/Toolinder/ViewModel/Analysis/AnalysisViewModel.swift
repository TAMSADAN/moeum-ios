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
        let tests = BehaviorRelay(value: [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1])
        //        let buyChartZip = BehaviorRelay(value: ChartZip(charts: [
        //            Chart(label: "1", value: 0.1),
        //            Chart(label: "2", value: 0.25),
        //            Chart(label: "3", value: 0.4),
        //            Chart(label: "4", value: 0.55),
        //            Chart(label: "5", value: 0.7),
        //            Chart(label: "6", value: 0.85),
        //            Chart(label: "7", value: 1),]))
        //
        let tradeChartZip = BehaviorRelay(value: TradeChartZip(TradeCharts: [
            TradeChart(buyChart: Chart(label: "1", value: 0.1, color: Const.Color.pink, valueOrigin: 123),
                       sellChart: Chart(label: "1", value: 0.2, color: Const.Color.mint, valueOrigin: 245)),
            TradeChart(buyChart: Chart(label: "2", value: 0.3, color: Const.Color.pink, valueOrigin: 123),
                       sellChart: Chart(label: "2", value: 0.7, color: Const.Color.mint, valueOrigin: 245)),
            TradeChart(buyChart: Chart(label: "3", value: 0.8, color: Const.Color.pink, valueOrigin: 123),
                       sellChart: Chart(label: "3", value: 0.5, color: Const.Color.mint, valueOrigin: 245)),
            TradeChart(buyChart: Chart(label: "4", value: 0.5, color: Const.Color.pink, valueOrigin: 123),
                       sellChart: Chart(label: "4", value: 0.2, color: Const.Color.mint, valueOrigin: 245)),
            TradeChart(buyChart: Chart(label: "5", value: 0.2, color: Const.Color.pink, valueOrigin: 123),
                       sellChart: Chart(label: "5", value: 0.7, color: Const.Color.mint, valueOrigin: 245)),
            TradeChart(buyChart: Chart(label: "6", value: 0.4, color: Const.Color.pink, valueOrigin: 123),
                       sellChart: Chart(label: "6", value: 0.6, color: Const.Color.mint, valueOrigin: 245)),
            TradeChart(buyChart: Chart(label: "7", value: 0.2, color: Const.Color.pink, valueOrigin: 123),
                       sellChart: Chart(label: "7", value: 0.9, color: Const.Color.mint, valueOrigin: 245)),
        ]))
        
        let tradeBarChartViewTypeOption = BehaviorRelay(value: 0)
        let tradeBarChartViewPeriodOption = BehaviorRelay(value: 0)
    }
    
    init() {
        setBind()
    }
}

extension AnalysisViewModel {
    func setBind() {
        input.tradeBarChartViewTypeOption
            .bind(to: output.tradeBarChartViewTypeOption)
            .disposed(by: disposeBag)
        
        input.tradeBarChartViewPeriodOption
            .bind(to: output.tradeBarChartViewPeriodOption)
            .disposed(by: disposeBag)
    }
}
