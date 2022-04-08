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
    
    var dataSource = Observable<[String]>.of((1...30).map(String.init))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
        self.setBind()
//        self.calendarView.dataSource = self
//        self.calendarView.delegate = self
    }
}
