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
        
        viewModel.output.records
            .bind(onNext: <#T##([Record]) -> Void#>)
        
        dataSource
            .bind(to : calendarView.rx.items(cellIdentifier: CalendarViewCell.identifier, cellType: CalendarViewCell.self)) {
                index, text, cell in cell.backgroundColor = .red
            }
            .disposed(by: disposeBag)
    }
}
