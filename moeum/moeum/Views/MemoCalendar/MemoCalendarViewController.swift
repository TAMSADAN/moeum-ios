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
    lazy var weekStackView = UIStackView()
    lazy var memoCalendarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    lazy var memoCalendarBottomSheetViewController = MemoCalendarBottomSheetViewController()
    
     
    
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    var calendarDate = Date()
    var days = [String]()
    var dates = [Date()]
    
    let memoCalendarBottomSheetDefaultTopConstant = 400.0
    var memoCalendarCollectionViewHideTopConstant: CGFloat!
    var memoCalendarCollectionViewTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.memoCalendarCollectionView.backgroundColor = .systemBlue
    }
    
    override func viewDidLayoutSubviews() {
        self.memoCalendarCollectionViewHideTopConstant = self.view.safeAreaLayoutGuide.layoutFrame.height - self.memoCalendarBottomSheetDefaultTopConstant
    }

    
}
