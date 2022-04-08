//
//  CalendarVC+Bind.swift
//  moeum
//
//  Created by 송영모 on 2022/04/07.
//

extension CalendarViewController {
    func setBind() {
        writingButton.rx.tap
            .bind { [weak self] in self?.goToWritingVC() }
            .disposed(by: disposeBag)
        

        headerView.pickerButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                let bool = !(self?.viewModel.input.isClickedDatePickerButton.value ?? false)
                self?.viewModel.input.isClickedDatePickerButton.accept(bool)
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

        
        //        viewModel.output.records
        
        dataSource
            .bind(to : calendarView.rx.items(cellIdentifier: CalendarViewCell.identifier, cellType: CalendarViewCell.self)) {
                index, text, cell in cell.backgroundColor = .red
            }
            .disposed(by: disposeBag)
    }
}
