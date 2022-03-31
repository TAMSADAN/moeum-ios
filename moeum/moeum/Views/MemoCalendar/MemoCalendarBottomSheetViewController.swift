//
//  MemoCalendarBottomSheetViewController.swift
//  moeum
//
//  Created by 송영모 on 2022/03/30.
//

import UIKit

class MemoCalendarBottomSheetViewController: UIViewController {
    
    lazy var contentView = UIView()
    lazy var bottomSheetView = UIView()
    
    var defaultHeightConstant = CGFloat()
    var maxHeightConstant = CGFloat()
    
    var contentViewHeightConstraint: NSLayoutConstraint!
    
    
    convenience init(constant: CGFloat) {
        self.init()
        self.defaultHeightConstant = constant
    }
    
    
    override func viewWillLayoutSubviews() {
        self.view.frame = CGRect(x: self.view.bounds.origin.x,
                                 y: self.view.frame.height,
            width: self.view.bounds.width,
                                 height: self.contentView.frame.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.view.backgroundColor = .blue
        self.view.alpha = 0.5
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showContentView()
    }
}
