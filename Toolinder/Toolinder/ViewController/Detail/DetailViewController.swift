//
//  DetailViewController.swift
//  Toolinder
//
//  Created by 송영모 on 2022/05/08.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import GoogleMobileAds

class DetailViewController: UIViewController, GADFullScreenContentDelegate {
    var recordZip: RecordZip!
    var disposeBag = DisposeBag()
    private var interstitial: GADInterstitialAd?
    
    var scrollView = UIScrollView()
    var sortButton = UIButton().then {
        $0.setTitle("최신 순", for: .normal)
        $0.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.titleLabel?.font = Const.Font.footnote
        $0.imageView?.tintColor = .black
        $0.imageView?.layer.transform = CATransform3DMakeScale(0.7, 0.7, 0.7)
    }
    var recordTableView = UITableView().then {
        $0.register(RecordTableViewCell.self, forCellReuseIdentifier: RecordTableViewCell.identifier)
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.rowHeight = 100
        $0.isScrollEnabled = false
    }
    var calButton = UIButton().then {
        $0.layer.cornerRadius = 15
        $0.setTitle("평단가 계산하기", for: .normal)
        $0.titleLabel?.font = Const.Font.headline
        $0.backgroundColor = Const.Color.blue
    }
    var recordTableViewAdaptor = RecordTableViewAdaptor()
    var recordTableViewHeightConstraint = NSLayoutConstraint()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(recordZip: RecordZip) {
        super.init(nibName: nil, bundle: nil)
        self.recordZip = recordZip
        recordTableViewAdaptor.update(self, recordZip: recordZip)
        
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: Secret.Key.fullAdmobId,
                               request: request,
                               completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
        }
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setView()
        setTableView()
        setBind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("DetailVC viewDidAppear")
        
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
        view.addSubview(calButton)
        scrollView.addSubview(sortButton)
        scrollView.addSubview(recordTableView)
        
        
        calButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        recordTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = Const.Color.white
        
        recordTableViewHeightConstraint = recordTableView.heightAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            sortButton.topAnchor.constraint(equalTo: scrollView.topAnchor),
            sortButton.trailingAnchor.constraint(equalTo: recordTableView.trailingAnchor, constant: -15),
            
            recordTableView.topAnchor.constraint(equalTo: sortButton.bottomAnchor),
            recordTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            recordTableView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            recordTableViewHeightConstraint,
            
            calButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            calButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            calButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            calButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

extension DetailViewController {
    func setBind() {
        calButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                let calculatorVC = CalculatorViewController(owner, recordZip: owner.recordZip)
                let navigationVC = UINavigationController(rootViewController: calculatorVC)
                owner.present(navigationVC, animated: true, completion: {
                    if owner.interstitial != nil {
                        owner.interstitial?.present(fromRootViewController: self)
                    } else {
                        print("Ad wasn't ready")
                    }
                })
            }
            .disposed(by: disposeBag)
    }
}

extension DetailViewController {
    func tryAd() {
        if Const.Ad.adCount >= 1 {
            print("이미 광고를 한번 시청했습니다.")
            return
        }
        if interstitial != nil {
            interstitial?.present(fromRootViewController: self)
            Const.Ad.adCount += 1
        } else {
            print("광고가 로드되지 않았습니다.")
        }
    }
    
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
