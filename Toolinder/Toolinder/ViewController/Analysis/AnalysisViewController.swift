//
//  AnalysisViewController.swift
//  Toolinder
//
//  Created by 송영모 on 2022/04/27.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import GoogleMobileAds

class AnalysisViewController: UIViewController, GADFullScreenContentDelegate {
    let viewModel = AnalysisViewModel()
    let disposeBag = DisposeBag()
    
    var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    var tradeBarChartView = TradeBarChartView()
    var divider = UIView().then {
        $0.backgroundColor = Const.Color.systemGray6
    }
    var recordZipTableLabel = UILabel()
        .then {
            $0.font = Const.Font.headline
            $0.textColor = .black
            $0.text = "종목별 투자 내역"
        }
    var recordZipTableView = UITableView().then {
        $0.register(RecordZipTableViewCell.self, forCellReuseIdentifier: RecordZipTableViewCell.identifier)
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.rowHeight = 65
        $0.isScrollEnabled = false
    }
    var recordZipTableViewAdaptor = RecordZipTableViewAdaptor()
    
    var recordZipListViewHeightConstraint = NSLayoutConstraint()
    private var interstitial: GADInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "분석"
        setView()
        setBind()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        recordZipListViewHeightConstraint.constant = recordZipTableView.contentSize.height
        print(recordZipTableView.contentSize.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refresh()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        if interstitial != nil {
//            interstitial?.present(fromRootViewController: self)
//        } else {
//            print("Ad wasn't ready")
//        }
//    }
}

extension AnalysisViewController {
    func updateRecordZipTableViewHeightConstraint() {
        recordZipListViewHeightConstraint.constant = recordZipTableView.contentSize.height
    }
    
    func setView() {
        view.addSubview(scrollView)
        scrollView.addSubview(tradeBarChartView)
        scrollView.addSubview(divider)
        scrollView.addSubview(recordZipTableLabel)
        scrollView.addSubview(recordZipTableView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        tradeBarChartView.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        recordZipTableLabel.translatesAutoresizingMaskIntoConstraints = false
        recordZipTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        
        recordZipTableView.delegate = recordZipTableViewAdaptor
        recordZipTableView.dataSource = recordZipTableViewAdaptor
        
        recordZipListViewHeightConstraint = recordZipTableView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            tradeBarChartView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            tradeBarChartView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            tradeBarChartView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            tradeBarChartView.heightAnchor.constraint(equalToConstant: 300),
            
            divider.topAnchor.constraint(equalTo: tradeBarChartView.bottomAnchor, constant: 15),
            divider.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            divider.heightAnchor.constraint(equalToConstant: 30),
            
            recordZipTableLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 15),
            recordZipTableLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            recordZipTableView.topAnchor.constraint(equalTo: recordZipTableLabel.bottomAnchor, constant: 5),
            recordZipTableView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            recordZipTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            recordZipListViewHeightConstraint,
        ])
    }
}

extension AnalysisViewController {
    func setBind() {
        tradeBarChartView.typeSegmentControl
            .rx
            .selectedSegmentIndex
            .bind(to: viewModel.input.tradeBarChartViewTypeOption)
            .disposed(by: disposeBag)
        
        tradeBarChartView.periodSegmentControl
            .rx
            .selectedSegmentIndex
            .bind(to: viewModel.input.tradeBarChartViewPeriodOption)
            .disposed(by: disposeBag)
        
        viewModel.output.tradeChartZips
            .withUnretained(self)
            .bind { owner, tradeChartZips in
                owner.tradeBarChartView.setTradeChartZips(tradeChartZips: tradeChartZips)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.recordZips
            .withUnretained(self)
            .bind { owner, recordZips in
                owner.recordZipTableViewAdaptor.update(self, recordZips: recordZips)
                owner.recordZipTableView.reloadData()
            }
            .disposed(by: disposeBag)
        
//        viewModel.output.recordZipTableViewCellModels
//            .withUnretained(self)
//            .bind { owner, recordZipTableViewCellModels in
//                owner.recordZipTableViewAdaptor.update(recordZips: <#T##[RecordZip]#>)
//                owner.recordZipTableView.reloadData()
//            }
//            .disposed(by: disposeBag)
        
//        viewModel.output.recordZips
//            .withUnretained(self)
//            .bind { owner, recordZips in
//                owner.recordZipTableViewAdaptor.recordZips = recordZips
//                owner.recordZipTableView.reloadData()
//            }
//            .disposed(by: disposeBag)

//        viewModel.output.recordZips
//            .bind(to: recordZipTableView.rx.items(cellIdentifier: RecordZipTitleTableViewCell.identifier, cellType: RecordZipTitleTableViewCell.self)) {
//                index, tmp, cell in
//                cell.selectionStyle = .none
//            }
//            .disposed(by: disposeBag)
        
//        viewModel.output.listItemModels
//            .bind(to: listTableView.rx.items(cellIdentifier: ListTableViewCell.identifier, cellType: ListTableViewCell.self)) {
//                index, listItemModel, cell in
//                cell.update(listItemModel: listItemModel)
//                cell.selectionStyle = .none
//            }
//            .disposed(by: disposeBag)
        
        viewModel.output.tradeBarChartViewTypeOption
            .withUnretained(self)
            .bind { owner, option in
                owner.tradeBarChartView.setTypeOption(option: option)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.tradeBarChartViewPeriodOption
            .withUnretained(self)
            .bind { owner, option in
                owner.tradeBarChartView.setPeriodOption(option: option)
            }
            .disposed(by: disposeBag)
    }
}

extension AnalysisViewController {
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
    }
    
    /// Tells the delegate that the ad will present full screen content.
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
    }
    
    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
    }
}
