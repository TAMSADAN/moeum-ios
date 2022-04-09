//
//  RecordRepository.swift
//  moeum
//
//  Created by 송영모 on 2022/04/06.
//

import Foundation
import RealmSwift

class RecordRepository {
    
    
    let instance = try! Realm()
    
    func getRecordEntity(recordId: Int) {
        
    }
    
    func getAllRecordEntity() -> [RecordEntity] {
        return Array(instance.objects(RecordEntity.self))
    }
    
    func postRecordEntity(recordEntity: RecordEntity) {
        var id = 0
        if let lastRecord = instance.objects(RecordEntity.self).last {
            id = lastRecord.id + 1
        }
        
        recordEntity.id = id
        try? instance.write {
            self.instance.add(recordEntity)
        }
        print(Realm.Configuration.defaultConfiguration.fileURL!)

    }
    
    func updateRecordEntity(recordId: Int, recordEntity: RecordEntity) {
        
    }
    
    func deleteRecordEntity(recordId: Int) {
        
    }
}
