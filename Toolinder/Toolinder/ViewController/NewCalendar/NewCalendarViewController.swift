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
    var prevCalendarCollectionView: CalendarCollectionView!
    var nowCalendarCollectionView: CalendarCollectionView!
    var nextCalendarCollectionView: CalendarCollectionView!
    var bottomSheet = NewCalendarBottomSheetView()
    
    var scrollViewHeightConstraint = NSLayoutConstraint()
    var scrollViewBottomConstraint = NSLayoutConstraint()
    var bottomSheetHeightConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        view.backgroundColor = Const.Color.white
        setView()
        setBind()
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.contentOffset.x = scrollView.frame.width
    }
}

extension NewCalendarViewController {
    func setView() {
        prevCalendarCollectionView = CalendarCollectionView()
        nowCalendarCollectionView = CalendarCollectionView()
        nextCalendarCollectionView = CalendarCollectionView()
        
        view.addSubview(scrollView)
        view.addSubview(headerView)
        view.addSubview(bottomSheet)
        
        scrollView.addSubview(prevCalendarCollectionView)
        scrollView.addSubview(nowCalendarCollectionView)
        scrollView.addSubview(nextCalendarCollectionView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        prevCalendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        nowCalendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        nextCalendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomSheet.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.delegate = self
        
        scrollViewBottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        bottomSheetHeightConstraint = bottomSheet.heightAnchor.constraint(equalToConstant: 0)
        
        hideBottomSheetView()
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: Const.Size.calendarHeaderMinHeight),
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
        ])
    }
}

extension NewCalendarViewController {
    func setBind() {
        headerView.datePicker.rx.date
            .withUnretained(self)
            .bind { owner, date in
                owner.viewModel.input.date.onNext(date)
                owner.viewModel.input.isClickedHeaderView.onNext(false)
            }
            .disposed(by: disposeBag)
        
        headerView.dateLabel.rx.tapGesture()
            .withUnretained(self)
            .bind { owner, tap in
                if tap.state.rawValue == 3 {
                    let bool = try! owner.viewModel.input.isClickedHeaderView.value()
                    owner.viewModel.input.isClickedHeaderView.onNext(!bool)
                }
            }
            .disposed(by: disposeBag)

        nowCalendarCollectionView
            .rx
            .itemSelected
            .withUnretained(self)
            .bind { owner, indexPath in
                let cell = owner.nowCalendarCollectionView.cellForItem(at: indexPath) as! CalendarCollectionViewCell
                owner.viewModel.input.isClickedCalendarCell.onNext(true)
                owner.viewModel.input.isClickedCalendarItem.onNext(cell.calendarItem)
            }
            .disposed(by: disposeBag)
        
        bottomSheet.hideButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.hideBottomSheetView()
            }
            .disposed(by: disposeBag)
        
//        bottomSheet.recordTableView.rx.tapGesture()
//            .withUnretained(self)
//            .bind { owner, tap in
//                print(tap.state.rawValue)
//            }
//            .disposed(by: disposeBag)
        
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
                    owner.headerView.show()
                } else {
                    owner.headerView.hide()
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
                owner.headerView.dateLabel.text = date.getCalendarDateString()
            }
            .disposed(by: disposeBag)
        
        viewModel.output.prevCalendarItems
            .withUnretained(self)
            .bind { owner, calendarItems in
                owner.prevCalendarCollectionView.update(owner.viewModel, calendarItems: calendarItems)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.nowCalendarItems
            .withUnretained(self)
            .bind { owner, calendarItems in
                owner.nowCalendarCollectionView.update(owner.viewModel, calendarItems: calendarItems)
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
    func showBottomSheetView() {
        scrollViewBottomConstraint.constant = -Const.Size.calendarBottomSheetMinHeight
        bottomSheetHeightConstraint.constant = Const.Size.calendarBottomSheetMinHeight
        
        UIView.animate(withDuration: 0.25, animations: {
            self.bottomSheet.alpha = 1
            self.scrollViewBottomConstraint.isActive = true
            self.bottomSheetHeightConstraint.isActive = true
            self.view.layoutIfNeeded()
        })
        
        //        for calendarCollectionViewCell in prevCalendarCollectionView.visibleCells {
//            let cell = calendarCollectionViewCell as! CalendarCollectionViewCell
//            cell.hide()
//        }
//        for calendarCollectionViewCell in nextCalendarCollectionView.visibleCells {
//            let cell = calendarCollectionViewCell as! CalendarCollectionViewCell
//            cell.hide()
//        }
        
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
