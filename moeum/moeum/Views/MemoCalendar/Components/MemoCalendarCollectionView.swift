//
//  MemoCalendarCollectionView.swift
//  moeum
//
//  Created by 송영모 on 2022/03/31.
//

import UIKit

class MemoCalendarCollectionView: UIView {
    
    lazy var contentView = UIView()
    lazy var memoCalendarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    func setup() {
        self.setupCollectionView()
    }
    
    private func setupViews() {
        
    }
    
    private func setupContentView() {
        self.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupCollectionView() {
        self.contentView.addSubview(self.memoCalendarCollectionView)
        self.memoCalendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayouts() {
        
    }
}
