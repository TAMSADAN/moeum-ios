//
//  MemoCalendarViewController.swift
//  moeum
//
//  Created by 송영모 on 2022/03/29.
//

import UIKit

class MemoCalendarViewController: UIViewController {
    lazy var contentView = UIView()
    lazy var monthPickerView = MemoCalendarMonthPickerView()
    lazy var weekView = MemoCalendarWeekView()
    lazy var memoCalendarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    lazy var memoCalendarBottomSheetViewController = MemoCalendarBottomSheetViewController()
    lazy var memoCalendarBottomSheetView = MemoCalendarBottomSheetView()
    lazy var createButton = UIButton()
    lazy var calendarButton = UIButton()
    lazy var chartButton = UIButton()
     
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    var calendarDate = Date()
    var days = [String]()
    var dates = [Date()]
    
    let memoCalendarBottomSheetDefaultHeight = 400.0
    var memoCalendarCollectionViewTopConstraint: NSLayoutConstraint!
    var memoCalendarBottomSheetViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
}

