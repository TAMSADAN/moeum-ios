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
    
    var tradeBarChartView = TradeBarChartView()
    
    private var interstitial: GADInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setBind()
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",
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
    
    override func viewDidAppear(_ animated: Bool) {
        if interstitial != nil {
            interstitial?.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }
}

extension AnalysisViewController {
    func setView() {
        view.addSubview(tradeBarChartView)
        
        tradeBarChartView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            tradeBarChartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            tradeBarChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tradeBarChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tradeBarChartView.heightAnchor.constraint(equalToConstant: 300),
            
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
