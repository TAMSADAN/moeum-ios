//
//  RecordService.swift
//  moeum
//
//  Created by 송영모 on 2022/04/06.
//

import Foundation

class RecordService {
    
    let recordRepository = RecordRepository()
    
    func getAllRecord() -> [Record] {
        let recordEntities = recordRepository.getAllRecordEntity()
        var records: [Record] = []
        
        for recordEntity in recordEntities {
            records.append(parseToRecord(recordEntity: recordEntity))
        }
        
        return records
    }
    
    func postRecord(record: Record) {
        print("postRecord")
        let recordEntity = parseToRecordEntity(record: record)
        recordRepository.postRecordEntity(recordEntity: recordEntity)
    }
    
    func updateRecord() {
        
    }
    
    func deleteRecord() {
        
    }
    
    private func parseToRecord(recordEntity: RecordEntity) -> Record {
        let record = Record(id: recordEntity.id,
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
                                        tag: record.tag,
                                        item: record.item,
                                        price: record.price,
                                        count: record.count,
                                        date: record.date,
                                        memo: record.memo)
        
        return recordEntity
    }
}
