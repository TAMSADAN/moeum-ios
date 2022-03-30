//
//  MemoCalendarBottomSheetViewController.swift
//  moeum
//
//  Created by 송영모 on 2022/03/30.
//

import UIKit

class MemoCalendarBottomSheetViewController: UIViewController {
    
    lazy var contentView = UIView()
    lazy var MemoCalendarBottomSheetView = UIView()
    
    var contentViewTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showConentView()
    }
}
