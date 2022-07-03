//
//  MiniCalendarView.swift
//  Toolinder
//
//  Created by 송영모 on 2022/07/03.
//

import UIKit

class MiniCalendarView: BaseView {
    
    let scrollView = UIScrollView()
    let prevCalendarView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let currentCalendarView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let nextCalendarView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func setupProperty() {
        super.setupProperty()
        
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        prevCalendarView.register(MiniCalendarCVC.self, forCellWithReuseIdentifier: MiniCalendarCVC.id)
        prevCalendarView.backgroundColor = .clear
        
        currentCalendarView.register(MiniCalendarCVC.self, forCellWithReuseIdentifier: MiniCalendarCVC.id)
        currentCalendarView.backgroundColor = .clear
        
        nextCalendarView.register(MiniCalendarCVC.self, forCellWithReuseIdentifier: MiniCalendarCVC.id)
        nextCalendarView.backgroundColor = .clear
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(scrollView)
        
        scrollView.addSubview(prevCalendarView)
        scrollView.addSubview(currentCalendarView)
        scrollView.addSubview(nextCalendarView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
//            $0.height.equalTo(Size.miniCalendarHeight)
        }
        
        prevCalendarView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
//            $0.width.equalTo(Size.miniCalendarWidth)
//            $0.height.equalTo(Size.miniCalendarHeight)
        }
        
        currentCalendarView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(prevCalendarView.snp.trailing)
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
//            $0.width.equalTo(Size.miniCalendarWidth)
//            $0.height.equalTo(Size.miniCalendarHeight)
        }
        
        nextCalendarView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(currentCalendarView.snp.trailing)
            $0.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
//            $0.width.equalTo(Size.miniCalendarWidth)
//            $0.height.equalTo(Size.miniCalendarHeight)
        }
    }
}
