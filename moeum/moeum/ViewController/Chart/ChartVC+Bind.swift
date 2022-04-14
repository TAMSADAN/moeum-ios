//
//  ChartVC+Bind.swift
//  moeum
//
//  Created by 송영모 on 2022/04/13.
//

import Foundation

extension ChartViewController {
    func setBind() {
        viewModel.output.recordChartDatas
            .bind { [weak self] recordChartdatas in
                let data = self?.viewModel.getThisMonthChartData() ?? ([Date()], [Double()])
                self?.setBarChartView(dates: data.0, values: data.1)

            }
            .disposed(by: disposBag)
    }
}
