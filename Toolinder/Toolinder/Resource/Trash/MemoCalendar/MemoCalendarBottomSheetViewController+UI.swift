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
    
    func showContentView() {
        self.contentViewHeightConstraint.constant = self.defaultHeightConstant
        
        UIView.animate(
            withDuration: 0.5,
            animations: {
                self.view.layoutIfNeeded()
            }
        )
    }
    
    func hideContentView() {
        self.contentViewHeightConstraint.constant = self.maxHeightConstant
        
        UIView.animate(
            withDuration: 0.5,
            animations: {
                self.view.layoutIfNeeded()
            }
        )
    }
    
    private func setupViews() {
        self.setupContentView()
    }
    
    private func setupContentView() {
        self.view.addSubview(self.contentView)
        self.contentView.backgroundColor = .systemGray6
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupLayouts() {
        self.contentViewHeightConstraint = self.contentView.heightAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            self.contentViewHeightConstraint,
            self.contentView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
