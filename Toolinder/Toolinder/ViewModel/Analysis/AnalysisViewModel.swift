//
//  AnalysisViewModel.swift
//  Toolinder
//
//  Created by 송영모 on 2022/04/27.
//

import Foundation
import RxSwift
import RxCocoa
import Algorithms

class AnalysisViewModel: ViewModel {
    let recordService = RecordService()
    let chartDataService = ChartDataService()
    let chartService = ChartService()
    
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
        let tradeChartZip = BehaviorRelay(value: TradeChartZip(tradeCharts: [
            TradeChart(buyChart: Chart(value: 0.1, color: Const.Color.pink),
                       sellChart: Chart(value: 0.2, color: Const.Color.mint)),
            TradeChart(buyChart: Chart(value: 0.3, color: Const.Color.pink),
                       sellChart: Chart(value: 0.7, color: Const.Color.mint)),
            TradeChart(buyChart: Chart(value: 0.8, color: Const.Color.pink),
                       sellChart: Chart(value: 0.5, color: Const.Color.mint)),
            TradeChart(buyChart: Chart(value: 0.5, color: Const.Color.pink),
                       sellChart: Chart(value: 0.2, color: Const.Color.mint)),
            TradeChart(buyChart: Chart(value: 0.2, color: Const.Color.pink),
                       sellChart: Chart(value: 0.7, color: Const.Color.mint)),
            TradeChart(buyChart: Chart(value: 0.4, color: Const.Color.pink),
                       sellChart: Chart(value: 0.6, color: Const.Color.mint)),
            TradeChart(buyChart: Chart(value: 0.2, color: Const.Color.pink),
                       sellChart: Chart(value: 0.9, color: Const.Color.mint)),
        ]))
        
        let tradeChartZips = BehaviorRelay(value: [
            TradeChartZip(tradeCharts: [
                Const.Test.tradeChart1,
            ], label: "1"),
            TradeChartZip(tradeCharts: [
                Const.Test.tradeChart2,
            ], label: "2"),
            TradeChartZip(tradeCharts: [
                Const.Test.tradeChart3,
            ], label: "3"),
            TradeChartZip(tradeCharts: [
                Const.Test.tradeChart4,
            ], label: "4"),
            TradeChartZip(tradeCharts: [
                Const.Test.tradeChart5,
            ], label: "5"),
            TradeChartZip(tradeCharts: [
                Const.Test.tradeChart6,
            ], label: "6"),
            TradeChartZip(tradeCharts: [
                Const.Test.tradeChart7,
            ], label: "7"),
        ])
        
        let tradeBarChartViewTypeOption = BehaviorRelay(value: 0)
        let tradeBarChartViewPeriodOption = BehaviorRelay(value: 0)
    }
    
    init() {
        setBind()
        print(chartService.getTradeChartZips(period: Period.day))
        print(chartService.getTradeChartZips(period: Period.week))
        print(chartService.getTradeChartZips(period: Period.month))
        print(chartService.getTradeChartZips(period: Period.year))
    }
}

extension AnalysisViewModel {
    func setBind() {
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
