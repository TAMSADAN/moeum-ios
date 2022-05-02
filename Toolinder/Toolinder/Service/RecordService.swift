//
//  RecordService.swift
//  moeum
//  
//  Created by 송영모 on 2022/04/06.
//

import Foundation

// Record
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
    
    func postRecord(record: Record) {
        let recordEntity = parseToRecordEntity(record: record)
        recordRepository.postRecordEntity(recordEntity: recordEntity)
    }
    
    func deleteRecord(recordId: Int) {
        recordRepository.deleteRecordEntity(recordId: recordId)
    }
    
    func getRecordZips(_ unit: Unit) -> [RecordZip] {
        let records: [Record] = getRecords()
        var oldRecords: [Record] = []
        var recordZips: [RecordZip] = []

        for record in records {
            if oldRecords.contains(where: {$0.id == record.id }) { continue }
            let equalUnitRecords: [Record] = records.filter({ $0.isEqaulUnit(record, unit: unit) })
            let recordZip = RecordZip(unit: unit, record: record, records: equalUnitRecords)
            oldRecords.append(contentsOf: equalUnitRecords)
            recordZips.append(recordZip)
        }
        return recordZips
    }
}


// RecordZip
extension RecordService {
    func getRecordZipsISOLDCODE(tag: Bool, item: Bool) -> [RecordZip] {
        let records: [Record] = getRecords()
        var recordZips: [RecordZip] = []
        
        for record in records {
            var recordZipIndex: Int?
            
            if tag && item {
                recordZipIndex = recordZips.firstIndex(where: { $0.record.item == record.item && $0.record.tag == record.tag })
            } else if tag && !item {
                recordZipIndex = recordZips.firstIndex(where: { $0.record.tag == record.tag })
            } else if !tag && item {
                recordZipIndex = recordZips.firstIndex(where: { $0.record.item == record.item })
            }
            
            if recordZipIndex != nil {
                recordZips[recordZipIndex!].addRecord(record: record)
            } else {
                let newRecordZip = RecordZip(unit: Unit.day, record: record, records: [record])
                recordZips.append(newRecordZip)
            }
        }
        return recordZips
    }
}

// Parse
extension RecordService {
    func parseToRecord(recordEntity: RecordEntity) -> Record {
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
    
    func parseToRecordEntity(record: Record) -> RecordEntity {
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
    
    func parseToListItemModel(record: Record, recordZip: RecordZip) -> ListItemModel {
        let (buyPriceAvg, buyCount) = recordZip.getBuyPriceData(date: record.date)
        let sum = Int(record.price * record.count)
        let sumGap = Int(record.price * record.count - buyPriceAvg * record.count)
        let price = Int(record.price)
        let priceGap = Int(record.price - buyPriceAvg)
        let count = Int(record.count)
        
        let listItemModel = ListItemModel(type: record.type,
                                          item: record.item,
                                          tag: record.tag,
                                          date: record.date.getString(),
                                          sum: String(sum),
                                          sumGap: String(sumGap),
                                          price: String(price),
                                          priceGap: String(priceGap),
                                          count: String(count),
                                          record: record)
        return listItemModel
    }
    
    func getHoldingAmountChartData(date: Date, recordZips: [RecordZip]) -> ChartData {
        var points: [String] = []
        var datas: [Double] = []
        
        for recordZip in recordZips {
            let point = recordZip.record.item
            let (buyPriceAvg, buyCount) = recordZip.getBuyPriceData(date: date)
            
            points.append(point)
            datas.append(buyPriceAvg * buyCount)
        }
        return ChartData(points: points, values: datas)
    }
}
