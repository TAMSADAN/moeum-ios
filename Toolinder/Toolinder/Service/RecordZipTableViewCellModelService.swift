//
//  ParsingService.swift
//  Toolinder
//
//  Created by 송영모 on 2022/05/06.
//

import Foundation

class RecordZipTableViewCellModelService {
    let recordZipService = RecordZipService()
    
    func getModels() -> [RecordZipTableViewCellModel] {
        var recordZipTableViewCellModels: [RecordZipTableViewCellModel] = []
        
        for recordZip in  recordZipService.getRecordZips(Unit.item) {
            let recordZipTableViewCellModel = RecordZipTableViewCellModel(isOpen: false, recordZip: recordZip)
            recordZipTableViewCellModels.append(recordZipTableViewCellModel)
        }
        return recordZipTableViewCellModels
    }
}
