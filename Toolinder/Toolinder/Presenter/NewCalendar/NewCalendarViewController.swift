//
//  NewCalendarViewController.swift
//  Toolinder
//
//  Created by 송영모 on 2022/05/03.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class NewCalendarViewController: UIViewController, UIScrollViewDelegate {
    let viewModel = NewCalendarViewModel()
    var disposeBag = DisposeBag()
    
    var scrollView = UIScrollView().then {
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
    }
    var headerView = NewCalendarHeaderView()
    var monthLabel = UILabel().then {
        $0.font = Const.Font.headline
        $0.text = "2022.4"
    }
    var datePicker = UIDatePicker().then {
            $0.timeZone = NSTimeZone.local
            $0.locale = Locale(identifier: "ko_KR")
            $0.minuteInterval = 10
            $0.datePickerMode = .date
            $0.backgroundColor = .white
            if #available(iOS 13.4, *) {
                $0.preferredDatePickerStyle = .wheels
            }
        }
    var prevCalendarCollectionView: CalendarCollectionView!
    var nowCalendarCollectionView: CalendarCollectionView!
    var nextCalendarCollectionView: CalendarCollectionView!
    var bottomSheet = NewCalendarBottomSheetView()
    var writingButton = WritingButton()
    var weekLabelView = WeekLabelView()
    
    var scrollViewHeightConstraint = NSLayoutConstraint()
    var scrollViewBottomConstraint = NSLayoutConstraint()
    var bottomSheetHeightConstraint = NSLayoutConstraint()
    var datePickerHeightConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        view.backgroundColor = Const.Color.white
//        navigationItem.title = "캘린더"
        setView()
        setBind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
    }
    
    
    override func viewDidLayoutSubviews() {
        scrollView.contentOffset.x = scrollView.frame.width
    }
}

extension NewCalendarViewController {
    func setView() {
        view.backgroundColor = Const.Color.white
        
        prevCalendarCollectionView = CalendarCollectionView()
        nowCalendarCollectionView = CalendarCollectionView()
        nextCalendarCollectionView = CalendarCollectionView()
        
        view.addSubview(scrollView)
        view.addSubview(monthLabel)
        view.addSubview(weekLabelView)
        view.addSubview(bottomSheet)
        view.addSubview(writingButton)
        view.addSubview(datePicker)
        
        scrollView.addSubview(prevCalendarCollectionView)
        scrollView.addSubview(nowCalendarCollectionView)
        scrollView.addSubview(nextCalendarCollectionView)
        
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        weekLabelView.translatesAutoresizingMaskIntoConstraints = false
        writingButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        prevCalendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        nowCalendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        nextCalendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomSheet.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.delegate = self
        datePicker.backgroundColor = Const.Color.white
        
        scrollViewBottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        bottomSheetHeightConstraint = bottomSheet.heightAnchor.constraint(equalToConstant: 0)
        datePickerHeightConstraint = datePicker.heightAnchor.constraint(equalToConstant: 0)
        
        hideBottomSheetView()
        
        NSLayoutConstraint.activate([
            monthLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            monthLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            datePicker.topAnchor.constraint(equalTo: monthLabel.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            datePickerHeightConstraint,

            weekLabelView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 15),
            weekLabelView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            weekLabelView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: weekLabelView.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollViewBottomConstraint,
            
            prevCalendarCollectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            prevCalendarCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            prevCalendarCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            prevCalendarCollectionView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            prevCalendarCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            nowCalendarCollectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            nowCalendarCollectionView.leadingAnchor.constraint(equalTo: prevCalendarCollectionView.trailingAnchor),
            nowCalendarCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            nowCalendarCollectionView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            nowCalendarCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            nextCalendarCollectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            nextCalendarCollectionView.leadingAnchor.constraint(equalTo: nowCalendarCollectionView.trailingAnchor),
            nextCalendarCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            nextCalendarCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            nextCalendarCollectionView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            nextCalendarCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            bottomSheet.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheet.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheet.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomSheetHeightConstraint,
            
            writingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            writingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
}

extension NewCalendarViewController {
    func setBind() {
        datePicker.rx.date
            .withUnretained(self)
            .bind { owner, date in
                owner.viewModel.input.date.onNext(date)
                owner.viewModel.input.isClickedHeaderView.onNext(false)
            }
            .disposed(by: disposeBag)
        
        monthLabel.rx.tapGesture()
            .withUnretained(self)
            .bind { owner, tap in
                if tap.state.rawValue == 3 {
                    let bool = try! owner.viewModel.input.isClickedHeaderView.value()
                    owner.viewModel.input.isClickedHeaderView.onNext(!bool)
                }
            }
            .disposed(by: disposeBag)
        
        writingButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                let writingVC = WritingViewController()
                writingVC.modalPresentationStyle = .fullScreen
                writingVC.writingView.datePicker.date = owner.viewModel.output.date.value
                self.present(writingVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        bottomSheet.hideButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.hideBottomSheetView()
            }
            .disposed(by: disposeBag)
        
        bottomSheet.recordTableView.rx.itemSelected
            .withUnretained(self)
            .bind { owner, indexPath in
                let cell = owner.bottomSheet.recordTableView.cellForRow(at: indexPath) as! RecordListTableViewCell
                let writingVC = WritingViewController()
                writingVC.modalPresentationStyle = .fullScreen
                writingVC.update(record: cell.record)
                self.present(writingVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.isShowHeaderView
            .withUnretained(self)
            .bind { owner, bool in
                if bool {
                    owner.showDatePicker()
                } else {
                    owner.hideDatePiecker()
                }
            }
            .disposed(by: disposeBag)

        viewModel.output.isShowBottomSheetView
            .withUnretained(self)
            .bind { owner, bool in
                if bool {
                    owner.showBottomSheetView()
                } else {
                    owner.hideBottomSheetView()
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.output.date
            .withUnretained(self)
            .bind { owner, date in
                owner.monthLabel.text = date.getCalendarDateString()
            }
            .disposed(by: disposeBag)
        
        viewModel.output.prevCalendarItems
            .withUnretained(self)
            .bind { owner, calendarItems in
                owner.prevCalendarCollectionView.update(owner.viewModel, calendarItems: calendarItems)
            }
            .disposed(by: disposeBag)
        
//        nowCalendarCollectionView.backgroundColor = Const.Color.orange
//        prevCalendarCollectionView.backgroundColor = Const.Color.indigo
//        nextCalendarCollectionView.backgroundColor = Const.Color.yellow
        viewModel.output.nowCalendarItems
            .withUnretained(self)
            .bind { owner, calendarItems in
                owner.nowCalendarCollectionView.update(owner.viewModel, calendarItems: calendarItems)
                owner.nowCalendarCollectionView.reloadData()
            }
            .disposed(by: disposeBag)
        
        viewModel.output.nextCalendarItems
            .withUnretained(self)
            .bind { owner, calendarItems in
                owner.nextCalendarCollectionView.update(owner.viewModel, calendarItems: calendarItems)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.bottomSheetCalendarItem
            .withUnretained(self)
            .bind { owner, calendarItem in
                owner.bottomSheet.update(calendarItem: calendarItem)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.bottomSheetCalendarItem
            .map { $0.records }
            .bind(to: bottomSheet.recordTableView.rx.items(cellIdentifier: RecordListTableViewCell.identifier, cellType: RecordListTableViewCell.self)) {
                index, record, cell in
                cell.update(record: record)
            }
            .disposed(by: disposeBag)
    }
}

extension NewCalendarViewController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > scrollView.frame.width {
            self.viewModel.input.date.onNext(try! self.viewModel.input.date.value().plusPeriod(Period.month, interval: 1))
        } else if scrollView.contentOffset.x < scrollView.frame.width {
            self.viewModel.input.date.onNext(try! self.viewModel.input.date.value().plusPeriod(Period.month, interval: -1))
        } else {
            
        }
        scrollView.contentOffset.x = scrollView.frame.width
    }
}

extension NewCalendarViewController {
    func showDatePicker() {
        datePickerHeightConstraint.constant = 290
        UIView.animate(withDuration: 0.25, animations: {
            self.datePickerHeightConstraint.isActive = true
            self.view.layoutIfNeeded()
        })
    }
    
    func hideDatePiecker() {
        datePickerHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.25, animations: {
            self.datePickerHeightConstraint.isActive = true
            self.view.layoutIfNeeded()
        })
    }
    
    func showBottomSheetView() {
        scrollViewBottomConstraint.constant = -Const.Size.calendarBottomSheetMinHeight
        bottomSheetHeightConstraint.constant = Const.Size.calendarBottomSheetMinHeight
        
        UIView.animate(withDuration: 0.25, animations: {
            self.bottomSheet.alpha = 1
            self.scrollViewBottomConstraint.isActive = true
            self.bottomSheetHeightConstraint.isActive = true
            self.view.layoutIfNeeded()
            self.nowCalendarCollectionView.performBatchUpdates(nil)
            self.prevCalendarCollectionView.performBatchUpdates(nil)
            self.nextCalendarCollectionView.performBatchUpdates(nil)
        }, completion: { _ in
            self.nowCalendarCollectionView.reloadData()
            self.prevCalendarCollectionView.reloadData()
            self.nextCalendarCollectionView.reloadData()
            
            UIView.animate(withDuration: 0.25, animations: {
                self.nowCalendarCollectionView.performBatchUpdates(nil)
                self.prevCalendarCollectionView.performBatchUpdates(nil)
                self.nextCalendarCollectionView.performBatchUpdates(nil)
            })
            
            for calendarCollectionViewCell in self.nowCalendarCollectionView.visibleCells {
                let cell = calendarCollectionViewCell as! CalendarCollectionViewCell
                cell.hide()
            }
        })
    }
    
    func hideBottomSheetView() {
        scrollViewBottomConstraint.constant = 0
        bottomSheetHeightConstraint.constant = 10
        UIView.animate(withDuration: 0.25, animations: {
            self.bottomSheet.alpha = 0
            self.scrollViewBottomConstraint.isActive = true
            self.bottomSheetHeightConstraint.isActive = true
            self.view.layoutIfNeeded()
            self.nowCalendarCollectionView.performBatchUpdates(nil)
            self.prevCalendarCollectionView.performBatchUpdates(nil)
            self.nextCalendarCollectionView.performBatchUpdates(nil)
        })
        
        for calendarCollectionViewCell in nowCalendarCollectionView.visibleCells {
            let cell = calendarCollectionViewCell as! CalendarCollectionViewCell
            cell.show()
        }
    }
}
