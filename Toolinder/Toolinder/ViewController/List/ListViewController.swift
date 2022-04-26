//
//  ListViewController.swift
//  moeum
//
//  Created by 송영모 on 2022/04/05.
//

import UIKit
import RxSwift
import Then

class ListViewController: UIViewController {
    let viewModel = ListViewModel()
    var disposeBag = DisposeBag()
    
    var scrollView = UIScrollView()
        .then {
            $0.showsVerticalScrollIndicator = false
        }
    
    var chartLabel = UILabel()
        .then {
            $0.font = Const.Font.headline
            $0.textColor = .black
            $0.text = "보유종목 3개"
        }
    
    var pieChartView = ItemPieChartView()
    
    var tradeCountLabel = UILabel()
        .then {
            $0.font = Const.Font.headline
            $0.textColor = .black
            $0.text = "투자내역 67개"
        }
    
    var sortButton = UIButton()
        .then {
            $0.setTitle("날짜 순", for: .normal)
            $0.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.semanticContentAttribute = .forceRightToLeft
            $0.titleLabel?.font = Const.Font.footnote
            $0.imageView?.tintColor = .black
            $0.imageView?.layer.transform = CATransform3DMakeScale(0.7, 0.7, 0.7)
        }
    
    var listTableView = UITableView()
        .then {
            $0.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
            $0.backgroundColor = .white
            $0.separatorStyle = .none
            $0.rowHeight = 70
            $0.isScrollEnabled = false
//            $0.autoresizingMask = .flexibleHeight
//            $0.estimatedRowHeight = 80
//            $0.rowHeight = UITableView.automaticDimension
        }

    var listTableViewHeightConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ListVC viewDidLoad")
        self.view.backgroundColor = .white
        navigationItem.title = "리스트"
        setView()
        setBind()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        listTableViewHeightConstraint.constant = listTableView.contentSize.height
    }
}
