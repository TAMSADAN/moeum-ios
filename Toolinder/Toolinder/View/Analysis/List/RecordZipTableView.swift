//
//  RecordZipTableView.swift
//  Toolinder
//
//  Created by 송영모 on 2022/05/05.
//

import UIKit

class RecordZipTableViewAdaptor: NSObject, UITableViewDelegate, UITableViewDataSource {
    var viewController: UIViewController!
    var recordZips: [RecordZip] = []
    
    func update(_ viewController: UIViewController, recordZips: [RecordZip]) {
        self.viewController = viewController
        self.recordZips = recordZips
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return recordZips.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecordZipTableViewCell.identifier, for: indexPath) as! RecordZipTableViewCell
        
        cell.update(recordZip: recordZips[indexPath.section])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? RecordZipTableViewCell else { return }
        let detailVC = DetailViewController(recordZip: cell.recordZip)
        
        viewController.navigationController?.pushViewController(detailVC, animated: true)
    }
}
