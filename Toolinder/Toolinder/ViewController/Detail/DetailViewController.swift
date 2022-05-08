//
//  DetailViewController.swift
//  Toolinder
//
//  Created by 송영모 on 2022/05/08.
//

import UIKit
import Then

class DetailViewController: UIViewController {
    var recordZip: RecordZip!
    var viewModel = DetailViewModel()
    
    var scrollView = UIScrollView()
    var recordTableView = UITableView().then {
        $0.register(RecordTableViewCell.self, forCellReuseIdentifier: RecordTableViewCell.identifier)
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.rowHeight = 100
        $0.isScrollEnabled = false
    }
    var recordTableViewAdaptor = RecordTableViewAdaptor()
    var recordTableViewHeightConstraint = NSLayoutConstraint()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(recordZip: RecordZip) {
        super.init(nibName: nil, bundle: nil)
        self.recordZip = recordZip
        viewModel.update(recordZip: recordZip)
        recordTableViewAdaptor.update(recordZip: recordZip)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setView()
        setTableView()   
    }
}

extension DetailViewController {
    func setNavigation() {
        title = recordZip.record.item
        navigationController?.navigationBar.topItem?.backButtonTitle = "분석"
        navigationController?.navigationBar.tintColor = Const.Color.black
    }
    
    func setTableView() {
        recordTableView.delegate = recordTableViewAdaptor
        recordTableView.dataSource = recordTableViewAdaptor
        recordTableView.reloadData()
        recordTableViewHeightConstraint.constant = recordTableView.contentSize.height
    }
    
    func setView() {
        view.addSubview(scrollView)
        scrollView.addSubview(recordTableView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        recordTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = Const.Color.white
        
        recordTableViewHeightConstraint = recordTableView.heightAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            recordTableView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            recordTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            recordTableView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            recordTableViewHeightConstraint,
        ])
    }
}
