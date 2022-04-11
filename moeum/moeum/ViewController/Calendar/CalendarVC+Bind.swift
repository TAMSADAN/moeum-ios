//
//  CalendarVC+Bind.swift
//  moeum
//
//  Created by 송영모 on 2022/04/07.
//

import RxSwift
import RxCocoa

extension CalendarViewController {
    func setBind() {
        writingButton.rx.tap
            .bind { [weak self] in self?.goToWritingVC() }
            .disposed(by: disposeBag)
        
        
        headerView.pickerButton.rx.tap
            .map { [weak self] in
                !(try! self?.viewModel.input.isClickedDatePickerButton.value() ?? false)
            }
            .bind(to: viewModel.input.isClickedDatePickerButton)
            .disposed(by: disposeBag)
        
        headerView.datePicker.rx.date
            .bind(to: viewModel.input.nowDate)
            .disposed(by: disposeBag)
        
        calendarView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        calendarView
            .rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                let cell = self?.calendarView.cellForItem(at: indexPath) as! CalendarViewCell
                self?.viewModel.input.cellData.onNext((cell.date, cell.records))
                // 같은 것
                if self?.viewModel.input.indexPath.value == indexPath {
                    self?.viewModel.input.indexPath.accept(IndexPath())
                    self?.showCalendarView()
                }
                // 다른 것
                else {
                    self?.showHighlightCell(indexPath: indexPath)
                    self?.viewModel.input.indexPath.accept(indexPath)
                    self?.hideCalendarView()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.input.cellData
            .subscribe(onNext: { [weak self] cellData in
                self?.bottomSheet.update(date: cellData.0, records: cellData.1)
            })
            .disposed(by: disposeBag)
        
        
        viewModel.output.datePickerOpen
            .subscribe(onNext: { [weak self] in
                if $0 {
                    self?.headerView.showDatePicker()
                } else {
                    self?.headerView.hideDatePicker()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.output.dateLabel
            .subscribe(onNext: {[weak self] in
                self?.headerView.monthLabel.text = $0
            })
            .disposed(by: disposeBag)
        
        viewModel.output.cellDatas
            .bind(to : calendarView.rx.items(cellIdentifier: CalendarViewCell.identifier, cellType: CalendarViewCell.self)) {
                index, cellData, cell in
                cell.update(date: cellData.0, records: cellData.1)
            }
            .disposed(by: disposeBag)
    }
}
