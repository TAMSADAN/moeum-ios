//
//  WritingViewController.swift
//  moeum
//
//  Created by 송영모 on 2022/04/04.
//

import UIKit
import RxSwift
import Then

class WritingViewController: UIViewController {
    var diposeBag = DisposeBag()
    
    var headerView = WritingHeaderView()
    var writingView = WritingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.binding()
    }
    
    override func viewDidLayoutSubviews() {
//        self.writingView.tagTextView.centerVertically()
    }
}
