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
        let record = Record(
            id: recordEntity.id,
            tagName: recordEntity.tagName,
            itemName: recordEntity.itemName,
            buyPrice: String(recordEntity.buyPrice),
            sellPrice: String(recordEntity.sellPrice),
            buyCount: String(recordEntity.buyCount),
            sellCount: String(recordEntity.sellCount),
            buyDate: recordEntity.buyDate,
            sellDate: recordEntity.sellDate,
            memo: recordEntity.memo
        )
        
        return record
    }
    
    private func parseToRecordEntity(record: Record) -> RecordEntity {
        let recordEntity = RecordEntity(
            tagName: record.tagName,
            itemName: record.itemName,
            buyPrice: Double(record.buyPrice) ?? 0.0,
            sellPrice: Double(record.sellPrice) ?? 0.0,
            buyCount: Double(record.buyCount) ?? 0.0,
            sellCount: Double(record.sellCount) ?? 0.0,
            buyDate: record.buyDate,
            sellDate: record.sellDate,
            memo: record.memo
        )
        
        return recordEntity
    }
}
