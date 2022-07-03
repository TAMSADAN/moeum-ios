//
//  BaseCVC.swift
//  Toolinder
//
//  Created by 송영모 on 2022/07/03.
//

import UIKit
import SnapKit

class BaseCVC: UICollectionViewCell, BaseViewProtocol {
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    func update() { }
    
    func setupProperty() { }
    
    func setupHierarchy() { }
    
    func setupLayout() { }
}
