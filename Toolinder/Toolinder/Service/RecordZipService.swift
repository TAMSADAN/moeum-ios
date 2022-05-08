//
//  RecordHelperService.swift
//  Toolinder
//
//  Created by 송영모 on 2022/05/05.
//

import Foundation

class RecordZipService {
    let recordService = RecordService()
    
    func getRecordZips(_ unit: Unit) -> [RecordZip] {
        let records: [Record] = recordService.getRecords()
        var oldRecords: [Record] = []
        var recordZips: [RecordZip] = []

        for record in records {
            if oldRecords.contains(where: {$0.id == record.id }) { continue }
            var equalUnitRecords: [Record] = records.filter({ $0.isEqaulUnit(record, unit: unit) })
            equalUnitRecords.sort(by: { $0.date > $1.date })
            let recordZip = RecordZip(unit: unit, record: record, records: equalUnitRecords)
            oldRecords.append(contentsOf: equalUnitRecords)
            recordZips.append(recordZip)
        }
        return recordZips
    }
}
