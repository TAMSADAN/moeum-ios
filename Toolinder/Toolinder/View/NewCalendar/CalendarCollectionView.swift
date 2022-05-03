//
//  CalendarCollectionView.swift
//  Toolinder
//
//  Created by 송영모 on 2022/05/03.
//

import UIKit

class CalendarCollectionView: UICollectionView {
    var viewModel: NewCalendarViewModel!
    var calendarItems: [CalendarItem]!
    var calendarCollectionViewFlowLayout: CalendarCollectionViewFlowLayout!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
    }
}

extension CalendarCollectionView {
    func update(_ viewModel: NewCalendarViewModel,calendarItems: [CalendarItem]) {
        self.viewModel = viewModel
        self.calendarItems = calendarItems
        self.calendarCollectionViewFlowLayout = CalendarCollectionViewFlowLayout(self)
        self.delegate = calendarCollectionViewFlowLayout
        self.dataSource = calendarCollectionViewFlowLayout
        self.reloadData()
    }
    
    func setView() {
        
    }
}

extension CalendarCollectionView {
    func setBind() {
        
    }
}
