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

class CalendarViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    var calendarDate = Date()
    var days = [String]()
    var dates = [Date()]
    
    var headerView = CalendarHeaderView()
    
    var calendarView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        .then {
            $0.register(MemoCalendarCollectionViewCell.self, forCellWithReuseIdentifier: MemoCalendarCollectionViewCell.identifier)
        }
    
    var writingButton = WritingButton()
    
    var weekLabelView = WeekLabelView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.binding()
        self.calendarView.dataSource = self
        self.calendarView.delegate = self
    }
}
