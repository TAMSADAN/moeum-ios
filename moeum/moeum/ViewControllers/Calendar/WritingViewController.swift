//
//  WritingViewController.swift
//  moeum
//
//  Created by 송영모 on 2022/04/04.
//

import UIKit
import Then

class WritingViewController: UIViewController {
    
    var headerView = WritingHeaderView()
    var writingView = WritingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
}
