//
//  DetailViewModel.swift
//  Toolinder
//
//  Created by 송영모 on 2022/05/08.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel: ViewModel {
    var recordZip: RecordZip!
    var disposeBag = DisposeBag()
    
    var input = Input()
    var output = Output()
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    init() {
        setBind()
    }
}

extension DetailViewModel {
    func update(recordZip: RecordZip) {
        self.recordZip = recordZip
    }
    
    func setBind() {
        
    }
}
