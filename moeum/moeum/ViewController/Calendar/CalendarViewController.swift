//
//  CalendarViewController.swift
//  moeum
//
//  Created by 송영모 on 2022/04/04.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import RealmSwift

class CalendarViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    let viewModel = CalendarViewModel()
    var disposeBag = DisposeBag()
    
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    var calendarDate = Date()
    var days = [String]()
    var dates = [Date()]
    
    var headerView = CalendarHeaderView()
    
    var calendarView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        .then {
            $0.register(CalendarViewCell.self, forCellWithReuseIdentifier: CalendarViewCell.identifier)
        }
    
    var writingButton = WritingButton()
    
    var weekLabelView = WeekLabelView()
    
    var bottomSheet = CalendarBottomSheet()
    
    var calendarViewBottomConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBind()
        self.setView()
//        calendarView.delegate = self
//        self.calendarView.dataSource = self
//        self.calendarView.delegate = self
    }
}
