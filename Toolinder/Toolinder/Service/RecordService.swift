//
//  RecordService.swift
//  moeum
//
//  Created by 송영모 on 2022/04/06.
//

import Foundation

class RecordService {
    
    let recordRepository = RecordRepository()
    
    func getRecords() -> [Record] {
        let recordEntities = recordRepository.getAllRecordEntity()
        var records: [Record] = []
        
        for recordEntity in recordEntities {
            records.append(parseToRecord(recordEntity: recordEntity))
        }
        
        return records
    }
    
    func getRecordZips(tag: Bool, item: Bool) -> [RecordZip] {
        let records: [Record] = getRecords()
        var recordZips: [RecordZip] = []
        
        for record in records {
            var recordZipIndex: Int?
            
            if tag && item {
                recordZipIndex = recordZips.firstIndex(where: { $0.item == record.item && $0.tag == record.tag })
            } else if tag && !item {
                recordZipIndex = recordZips.firstIndex(where: { $0.tag == record.tag })
            } else if !tag && item {
                recordZipIndex = recordZips.firstIndex(where: { $0.item == record.item })
            }
            
            if recordZipIndex != nil {
                recordZips[recordZipIndex!].addRecord(record: record)
            } else {
                let newRecordZip = RecordZip(tag: record.tag, item: record.item, records: [record])
                recordZips.append(newRecordZip)
            }
        }
        
        return recordZips
    }
    //    func getRecordZip(type: String, item: String) -> RecordZip? {
    //        let recordZips = getRecordZips()
    //
    //        if let recordZipIndex = recordZips.firstIndex(where: { $0.item == item && }) {
    //            return recordZips[recordZipIndex]
    //        }
    //        return nil
    //    }
    
    func postRecord(record: Record) {
        let recordEntity = parseToRecordEntity(record: record)
        recordRepository.postRecordEntity(recordEntity: recordEntity)
    }
    
    func updateRecord() {
        
    }
    
    func deleteRecord(recordId: Int) {
        recordRepository.deleteRecordEntity(recordId: recordId)
    }
    
    private func parseToRecord(recordEntity: RecordEntity) -> Record {
        let record = Record(id: recordEntity.id,
                            type: recordEntity.type,
                            tag: recordEntity.tag,
                            item: recordEntity.item,
                            price: recordEntity.price,
                            count: recordEntity.count,
                            date: recordEntity.date,
                            memo: recordEntity.memo)
        
        return record
    }
    
    private func parseToRecordEntity(record: Record) -> RecordEntity {
        let recordEntity = RecordEntity(id: record.id,
                                        type: record.type,
                                        tag: record.tag,
                                        item: record.item,
                                        price: record.price,
                                        count: record.count,
                                        date: record.date,
                                        memo: record.memo)
        
        return recordEntity
    }
}
