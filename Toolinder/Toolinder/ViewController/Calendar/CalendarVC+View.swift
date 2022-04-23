//
//  CalendarVC+UI.swift
//  moeum
//
//  Created by 송영모 on 2022/04/04.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

extension CalendarViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = calendarView.frame.width / 7
        let height = calendarView.frame.height / 5
            return CGSize(width: width, height: height)
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return .zero
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return .zero
        }
    
    func setView() {
        view.addSubview(monthLabel)
        
        view.addSubview(weekLabelView)
        view.addSubview(calendarView)
        view.addSubview(bottomSheet)
        view.addSubview(recordListView)
        view.addSubview(writingButton)
        view.addSubview(datePickerBackView)
        view.addSubview(datePicker)
        
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePickerBackView.translatesAutoresizingMaskIntoConstraints = false
//        headerView.translatesAutoresizingMaskIntoConstraints = false
        weekLabelView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        writingButton.translatesAutoresizingMaskIntoConstraints = false
        bottomSheet.translatesAutoresizingMaskIntoConstraints = false
        recordListView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        bottomSheet.alpha = 0
        calendarViewBottomConstraint =  calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
//        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 20)
        datePickerBackViewBottomConstraint = datePickerBackView.bottomAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 0)
        
        NSLayoutConstraint.activate([
//            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            headerHeightConstraint,
            
            monthLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            monthLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            datePickerBackView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor),
            datePickerBackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            datePickerBackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            datePickerBackViewBottomConstraint,
            
            datePicker.topAnchor.constraint(equalTo: datePickerBackView.topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: datePickerBackView.leadingAnchor, constant: 10),
            datePicker.trailingAnchor.constraint(equalTo: datePickerBackView.trailingAnchor, constant: -10),
            datePicker.bottomAnchor.constraint(equalTo: datePickerBackView.bottomAnchor),
            
            weekLabelView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 15),
            weekLabelView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            weekLabelView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            calendarView.topAnchor.constraint(equalTo: weekLabelView.bottomAnchor, constant: 5),
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calendarViewBottomConstraint,
            
            bottomSheet.topAnchor.constraint(equalTo: calendarView.bottomAnchor),
            bottomSheet.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomSheet.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomSheet.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            writingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            writingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            recordListView.topAnchor.constraint(lessThanOrEqualTo: bottomSheet.recordFixedLabel.bottomAnchor),
            recordListView.leadingAnchor.constraint(equalTo: bottomSheet.leadingAnchor),
            recordListView.trailingAnchor.constraint(equalTo: bottomSheet.trailingAnchor),
            recordListView.bottomAnchor.constraint(equalTo: bottomSheet.bottomAnchor),
        ])
    }
}

extension CalendarViewController {
    func setBind() {
        monthLabel
            .rx
            .tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind { owner, _ in
                let bool = try! owner.viewModel.input.isMonthLabelClicked.value()
                owner.viewModel.input.isMonthLabelClicked.onNext(!bool)
            }
            .disposed(by: disposeBag)
        
        datePicker
            .rx
            .date
            .bind(to: viewModel.input.datePickerDate)
            .disposed(by: disposeBag)
        
        bottomSheet.hideButton.rx.tapGesture()
            .withUnretained(self)
            .subscribe { owner, event in
                owner.showCalendarView()
                owner.viewModel.input.calendarSelectedCellData.onNext((IndexPath(), Date(), []))
                
            }
            .disposed(by: disposeBag)
        
        writingButton.rx.tap
            .bind { [weak self] in self?.goToWritingVC() }
            .disposed(by: disposeBag)
        
        calendarView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        calendarView
            .rx
            .itemSelected
            .withUnretained(self)
            .bind { owner, indexPath in
                let cell = owner.calendarView.cellForItem(at: indexPath) as! CalendarViewCell
                let prevIndexPath = try! owner.viewModel.input.calendarSelectedCellData.value().0
                var nowIndexPath = indexPath
                
                if indexPath == prevIndexPath {
                    nowIndexPath = IndexPath()
                    owner.showCalendarView()
                } else {
                    owner.hideCalendarView()
                }
                owner.viewModel.input.calendarSelectedCellData.onNext((nowIndexPath, cell.date, cell.records))
            }
            .disposed(by: disposeBag)
        
        recordListView.rx.itemSelected
            .withUnretained(self)
            .bind { owner, indexPath in
                let cell = owner.recordListView.cellForRow(at: indexPath) as! RecordListViewCell
                let writingVC = WritingViewController()
                writingVC.modalPresentationStyle = .fullScreen
                writingVC.update(record: cell.record)
                self.present(writingVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.monthLabelText
            .withUnretained(self)
            .bind { owner, text in
                owner.monthLabel.text = text
                owner.viewModel.input.isMonthLabelClicked.onNext(false)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.datePickerOpen
            .withUnretained(self)
            .bind { owner, bool in
                bool ? owner.showDatePicker() : owner.hideDatePicker()
            }
            .disposed(by: disposeBag)
        
        viewModel.output.calendarCellDatas
            .bind(to : calendarView.rx.items(cellIdentifier: CalendarViewCell.identifier, cellType: CalendarViewCell.self)) {
                index, cellData, cell in
                cell.update(date: cellData.0, records: cellData.1)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.bottomSheetRecords
            .bind(to: recordListView.rx.items(cellIdentifier: RecordListViewCell.identifier, cellType: RecordListViewCell.self)) {
                index, record, cell in
                cell.update(record: record)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.bottomSheetDate
            .withUnretained(self)
            .bind { owner, date in
                owner.bottomSheet.update(date: date)
            }
            .disposed(by: disposeBag)
    }
}


extension CalendarViewController {
    func showDatePicker() {
        datePickerBackViewBottomConstraint.constant = 216
        
        UIView.animate(withDuration: 0.25, animations: {
            self.datePickerBackViewBottomConstraint.isActive = true
            self.view.layoutIfNeeded()
        })
        
    }
    
    func hideDatePicker() {
        datePickerBackViewBottomConstraint.constant = 0
        
        UIView.animate(withDuration: 0.25, animations: {
            self.datePickerBackViewBottomConstraint.isActive = true
            self.view.layoutIfNeeded()
        })
    }
    
    func showCalendarView() {
        calendarViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.25, animations: {
            self.calendarViewBottomConstraint.isActive = true
            self.bottomSheet.alpha = 0
            self.view.layoutIfNeeded()
            
            self.calendarView.performBatchUpdates(nil)
        })
        
        for CalendarViewCell in calendarView.visibleCells {
            let cell = CalendarViewCell as! CalendarViewCell
            cell.show()
        }
    }
    
    func hideCalendarView() {
        calendarViewBottomConstraint.constant = -500
        UIView.animate(withDuration: 0.25, animations: {
            self.calendarViewBottomConstraint.isActive = true
            self.bottomSheet.alpha = 1
            self.view.layoutIfNeeded()
            self.calendarView.performBatchUpdates(nil)
            
        })
        
        for CalendarViewCell in calendarView.visibleCells {
            let cell = CalendarViewCell as! CalendarViewCell
            cell.hide()
        }
    }
    
    func showHighlightCell(indexPath: IndexPath) {
        for CalendarViewCell in calendarView.visibleCells {
            let cell = CalendarViewCell as! CalendarViewCell
            cell.hideHighlight()
        }
        
        let cell = calendarView.cellForItem(at: indexPath) as! CalendarViewCell
        cell.showHighlight()
    }
}
