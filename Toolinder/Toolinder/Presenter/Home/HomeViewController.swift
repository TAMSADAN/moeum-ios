//
//  HomeViewController.swift
//  Toolinder
//
//  Created by 송영모 on 2022/07/03.
//

import UIKit
import SnapKit

class HomeViewController: BaseViewController {
    
    let selfView = HomeView()
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .gray1
        
        selfView.miniCalendarView.prevCalendarView.delegate = self
        selfView.miniCalendarView.prevCalendarView.dataSource = self
        selfView.miniCalendarView.currentCalendarView.delegate = self
        selfView.miniCalendarView.currentCalendarView.dataSource = self
        selfView.miniCalendarView.nextCalendarView.delegate = self
        selfView.miniCalendarView.nextCalendarView.dataSource = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(selfView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        selfView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setupBind() {
        super.setupBind()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7.0
        let height = collectionView.frame.height / CGFloat(30 / 7)
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniCalendarCVC.id, for: indexPath) as? MiniCalendarCVC else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}
