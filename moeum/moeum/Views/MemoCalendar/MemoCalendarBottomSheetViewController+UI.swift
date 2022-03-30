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
        self.contentViewTopConstraint.constant = self.defaultHeightConstant
        
        UIView.animate(
            withDuration: 0.5,
            animations: {
                self.view.layoutIfNeeded()
            }
        )
    }
    
    func hideContentView() {
        self.contentViewTopConstraint.constant = self.maxHeightConstant
        
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
        self.contentView.backgroundColor = .white
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayouts() {
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height - 47
        print("dd")
        print(view.safeAreaInsets.bottom)
        print(view.safeAreaLayoutGuide.layoutFrame.height)
        print("kk")
//        self.maxHeightConstant = self.view.frame.height -
        self.contentViewTopConstraint = self.contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
        NSLayoutConstraint.activate([
            self.contentViewTopConstraint,
            self.contentView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
