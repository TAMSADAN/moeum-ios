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
    var viewModel = WritingViewModel()
    var disposeBag = DisposeBag()
    
    var headerView = WritingHeaderView()
    var writingView = WritingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
        self.setBind()
    }
}
