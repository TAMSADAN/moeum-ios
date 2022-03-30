//
//  MemoCalendarBottomSheetViewController+UI.swift
//  moeum
//
//  Created by 송영모 on 2022/03/30.
//

import UIKit

extension MemoCalendarBottomSheetViewController {
    
    func setup() {
        self.setupViews()
        self.setupLayouts()
    }
    
    func showConentView() {
        print(self.view.frame.height)
        self.contentViewTopConstraint.constant = 300
        UIView.animate(
            withDuration: 0.25,
            animations: {
                self.view.layoutIfNeeded()
            }
        )
    }
    
    private func setupViews() {
        self.setupContentView()
        self.setupMemoCalendarBottomSheetView()
    }
    
    private func setupContentView() {
        self.view.addSubview(self.contentView)
        self.contentView.backgroundColor = .cyan
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupMemoCalendarBottomSheetView() {
        self.contentView.addSubview(self.MemoCalendarBottomSheetView)
        self.MemoCalendarBottomSheetView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayouts() {
        self.contentViewTopConstraint = self.contentView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height)
        NSLayoutConstraint.activate([
            self.contentViewTopConstraint,
            self.contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
