//
//  ScheduleView.swift
//  Toolinder
//
//  Created by 송영모 on 2022/06/27.
//

import Foundation
import UIKit

class ScheduleView: BaseView {
    
    let scrollView          = UIScrollView()
    let prevCalendarView    = UICollectionView(frame: .zero,
                                            collectionViewLayout: UICollectionViewFlowLayout())
    let currentCalendarView = UICollectionView(frame: .zero,
                                               collectionViewLayout: UICollectionViewFlowLayout())
    let nextCalendarView    = UICollectionView(frame: .zero,
                                               collectionViewLayout: UICollectionViewFlowLayout())
    
    override func setupProperty() {
        super.setupProperty()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
    }
    
    override func setupLayout() {
        super.setupLayout()
    }
}
