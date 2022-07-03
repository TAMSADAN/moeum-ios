//
//  ListVM+Ext.swift
//  Toolinder
//
//  Created by 송영모 on 2022/04/25.
//

import Foundation
import RxSwift
import RxCocoa

extension ListViewModel {
    func setBind() {
        input.refresh
            .withUnretained(self)
            .bind { owner, _ in
                owner.input.records.onNext(owner.recordService.getRecords())
                owner.input.itemRecordZips.onNext(owner.recordService.getRecordZipsISOLDCODE(tag: false, item: true))
            }
            .disposed(by: disposeBag)
        
        input.records
            .withUnretained(self)
            .bind { owner, records in
                owner.output.records.accept(records.reversed())
                owner.output.tradeHistoryCount.accept(records.count)
            }
            .disposed(by: disposeBag)
        
        input.itemRecordZips
            .withUnretained(self)
            .bind { owner, recordZips in
                let holdingAmountChartData = owner.chartDataService.getHoldingAmountChartData(date: Date(), recordZips: recordZips)
                owner.output.holdingAmountChartData.accept(holdingAmountChartData)
                owner.output.holdingCount.accept(holdingAmountChartData.points.count)
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(input.records, input.itemRecordZips)
            .withUnretained(self)
            .bind { owner, data in
                let records = data.0.sorted(by: {$0.date > $1.date})
                let recordZips = data.1
                var listItemModels: [ListItemModel] = []
                
                for record in records {
                    let recordZip = recordZips.first(where: { $0.record.item == record.item }) ?? RecordZip()
                    let listItemModel = owner.recordService.parseToListItemModel(record: record, recordZip: recordZip)
                    
                    listItemModels.append(listItemModel)
                }
                owner.output.listItemModels.accept(listItemModels)
            }
            .disposed(by: disposeBag)
    }
}
