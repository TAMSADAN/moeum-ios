//
//  WritingVC+UI.swift
//  moeum
//
//  Created by 송영모 on 2022/04/04.
//

import UIKit
import RxSwift
import RxCocoa

extension WritingViewController {
    func setView() {
        view.addSubview(headerView)
        view.addSubview(writingView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        writingView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            writingView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            writingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            writingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            writingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
