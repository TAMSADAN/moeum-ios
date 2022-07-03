//
//  HomeView.swift
//  Toolinder
//
//  Created by 송영모 on 2022/07/03.
//

import UIKit

class HomeView: BaseView {
    
    let scrollView = UIScrollView()
    let miniCalendarCardView = CardView()
    let miniCalendarLabel = UILabel()
    let miniCalendarView = MiniCalendarView()
    
    override func setupProperty() {
        super.setupProperty()
        
        miniCalendarLabel.text = "일정"
        miniCalendarLabel.font = .systemFont(ofSize: 23, weight: .semibold)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(scrollView)
        
        scrollView.addSubview(miniCalendarCardView)
        
        miniCalendarCardView.addSubview(miniCalendarLabel)
        miniCalendarCardView.addSubview(miniCalendarView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        miniCalendarCardView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Size.cardWidth)
            $0.height.equalTo(Size.cardCalendarHeight)
        }
        
        miniCalendarLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(20)
        }
        
        miniCalendarView.snp.makeConstraints {
            $0.top.equalTo(miniCalendarLabel.snp.bottom).inset(-20)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }
}
