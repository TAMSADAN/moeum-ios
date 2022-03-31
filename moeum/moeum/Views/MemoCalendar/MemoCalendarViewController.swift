//
//  MemoCalendarViewController.swift
//  moeum
//
//  Created by 송영모 on 2022/03/29.
//

import UIKit

class MemoCalendarViewController: UIViewController {
    lazy var contentView = UIView()
    lazy var monthPickerLabel = UILabel()
    lazy var monthPickerButton = UIButton()
    lazy var monthPickerView = MemoCalendarMonthPickerView()
    lazy var weekView = MemoCalendarWeekView()
    lazy var memoCalendarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    lazy var memoCalendarBottomSheetViewController = MemoCalendarBottomSheetViewController()
    lazy var memoCalendarBottomSheetView = MemoCalendarBottomSheetView()
     
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
//        self.memoCalendarCollectionView.backgroundColor = .red
    }
}

