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
    
    var monthLabel = UILabel()
        .then {
            $0.font = .systemFont(ofSize: 25, weight: .bold)
            $0.textColor = .black
            $0.text = "2022.3"
        }
    
    var datePickerBackView = UIView()
        .then {
            $0.backgroundColor = .white
        }
    
    var datePicker = UIDatePicker()
        .then {
            $0.timeZone = NSTimeZone.local
            $0.locale = Locale(identifier: "ko_KR")
            $0.minuteInterval = 10
            $0.datePickerMode = .date
            $0.backgroundColor = .white
            if #available(iOS 13.4, *) {
                $0.preferredDatePickerStyle = .wheels
            }
        }
    
    var calendarView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        .then {
            $0.register(CalendarViewCell.self, forCellWithReuseIdentifier: CalendarViewCell.identifier)
        }
    
    var recordListView = UITableView()
        .then {
            $0.register(RecordListTableViewCell.self, forCellReuseIdentifier: RecordListTableViewCell.identifier)
            $0.rowHeight = 70
            $0.backgroundColor = .white
            $0.separatorStyle = .none
        }
    
    var writingButton = WritingButton()
    
    var weekLabelView = WeekLabelView()
    
    var bottomSheet = CalendarBottomSheet()
    
    var calendarViewBottomConstraint = NSLayoutConstraint()
    
    var datePickerBackViewBottomConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
        self.setBind()
    }
}
