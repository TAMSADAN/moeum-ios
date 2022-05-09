//
//  CalculatorViewModel.swift
//  Toolinder
//
//  Created by 송영모 on 2022/05/08.
//

import Foundation
import RxSwift
import RxCocoa

class CalculatorViewModel: ViewModel {
    var recordZip: RecordZip!
    var disposeBag = DisposeBag()
    
    var input = Input()
    var output = Output()
    
    struct Input {
        let inputPrice = BehaviorRelay(value: 0.0)
        let inputCount = BehaviorRelay(value: 0.0)
    }
    
    struct Output {
        let resultPriceText = BehaviorRelay(value: "")
        let resultCountText = BehaviorRelay(value: "")
        let resultSumText = BehaviorRelay(value: "")
        let nowPriceText = BehaviorRelay(value: "")
        let nowCountText = BehaviorRelay(value: "")
        let nowSumText = BehaviorRelay(value: "")
        let inputPriceText = BehaviorRelay(value: "")
        let inputCountText = BehaviorRelay(value: "")
        let inputSumText = BehaviorRelay(value: "")
    }
    
    init() {
        setBind()
    }
}

extension CalculatorViewModel {
    func update(recordZip: RecordZip) {
        let (buyPriceAvg, buyCount) = recordZip.getBuyDataAt(record: recordZip.records.first ?? Record())
        
        output.nowPriceText.accept(String(buyPriceAvg).insertComma + "원")
        output.nowCountText.accept(String(buyCount).insertComma + "개")
    }
    
    func setBind() {
        input.inputPrice
            .map {
                String($0).insertComma + "원"
            }
            .bind(to: output.inputPriceText)
            .disposed(by: disposeBag)
        
        input.inputCount
            .map {
                String($0).insertComma + "개"
            }
            .bind(to: output.inputCountText)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(output.nowPriceText, output.nowCountText)
            .withUnretained(self)
            .bind { owner, data in
                let nowPrice = Double(data.0.replacingOccurrences(of: "원", with: "").replacingOccurrences(of: ",", with: "")) ?? 0.0
                let nowCount = Double(data.1.replacingOccurrences(of: "개", with: "").replacingOccurrences(of: ",", with: "")) ?? 0.0
                let nowSum = String(nowPrice * nowCount)
                
                owner.output.nowSumText.accept(nowSum.insertComma + "원")
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(output.inputPriceText, output.inputCountText)
            .withUnretained(self)
            .bind { owner, data in
                let inputPrice = Double(data.0.replacingOccurrences(of: "원", with: "").replacingOccurrences(of: ",", with: "")) ?? 0.0
                let inputCount = Double(data.1.replacingOccurrences(of: "개", with: "").replacingOccurrences(of: ",", with: "")) ?? 0.0
                let inputSum = String(inputPrice * inputCount)
                
                owner.output.inputSumText.accept(inputSum.insertComma + "원")
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(output.nowSumText, output.inputSumText, output.nowCountText, output.inputCountText)
            .withUnretained(self)
            .bind { owner, data in
                let nowSum = Double(data.0.replacingOccurrences(of: "원", with: "").replacingOccurrences(of: ",", with: "")) ?? 0.0
                let inputSum = Double(data.1.replacingOccurrences(of: "원", with: "").replacingOccurrences(of: ",", with: "")) ?? 0.0
                let nowCount = Double(data.2.replacingOccurrences(of: "개", with: "").replacingOccurrences(of: ",", with: "")) ?? 0.0
                let inputCount = Double(data.3.replacingOccurrences(of: "개", with: "").replacingOccurrences(of: ",", with: "")) ?? 0.0
                
                let resultPriceText = String((nowSum + inputSum) / (nowCount + inputCount)).insertComma + "원"
                let resultCountText = String((nowCount + inputCount)).insertComma + "개"
                let resultSumText = String((nowSum + inputSum)).insertComma + "원"
                
                owner.output.resultPriceText.accept(resultPriceText)
                owner.output.resultCountText.accept(resultCountText)
                owner.output.resultSumText.accept(resultSumText)
            }
            .disposed(by: disposeBag)
    }
}
