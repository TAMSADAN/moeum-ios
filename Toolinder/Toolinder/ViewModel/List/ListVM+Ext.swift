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
        input.records
            .map { records in
                return records.reversed()   
            }
            .bind(to: output.records)
//            .bind { _ in
//                self.output.records.accept([Record(),Record(),Record(),Record(),Record(),Record(),Record(),Record(),Record(),Record(),Record(),Record(),Record(),Record(),Record(),Record(),])
//            }
            .disposed(by: disposeBag)
        
        input.itemRecordZips
            .withUnretained(self)
            .bind { owner, recordZips in
                owner.output.holdingAmountChartData.accept(owner.chartDataService.getHoldingAmountChartData(date: Date(), recordZips: recordZips))
            }
            .disposed(by: disposeBag)
    }
}
