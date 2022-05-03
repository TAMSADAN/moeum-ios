//
//  CalendarCollectionViewFlowLayout.swift
//  Toolinder
//
//  Created by 송영모 on 2022/05/03.
//

import UIKit
import RxSwift
import RxCocoa

class CalendarCollectionViewFlowLayout: UICollectionViewFlowLayout, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var calendarCollectionView: CalendarCollectionView!
    var calendarItems: [CalendarItem]!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(_ calendarCollectionView: CalendarCollectionView) {
        super.init()
        print("초기화")
        self.calendarCollectionView = calendarCollectionView
        self.calendarItems = calendarCollectionView.calendarItems
    }
}

extension CalendarCollectionViewFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = calendarCollectionView.frame.width / 7
        let height = calendarCollectionView.frame.height / (CGFloat(calendarItems.count) / 7.0)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as! CalendarCollectionViewCell
        
        cell.update(calendarItem: calendarItems[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        calendarCollectionView.viewModel.input.isClickedCalendarCell.onNext(true)
        calendarCollectionView.viewModel.input.date.onNext(calendarItems[indexPath.row].date)
    }
}
