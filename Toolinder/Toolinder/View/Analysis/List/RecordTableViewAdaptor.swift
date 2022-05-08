//
//  RecordTableViewAdaptor.swift
//  Toolinder
//
//  Created by 송영모 on 2022/05/08.
//

import UIKit

class RecordTableViewAdaptor: NSObject, UITableViewDelegate, UITableViewDataSource {
    var updateRecordZipTableViewHeightConstraint : (()->())!
    var recordZip: RecordZip!
    
    func update(recordZip: RecordZip) {
        self.recordZip = recordZip
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return recordZip.records.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewCell.identifier, for: indexPath) as! RecordTableViewCell
        cell.update(recordZip: recordZip, record: recordZip.records[indexPath.section])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       print(indexPath)
    }
}
