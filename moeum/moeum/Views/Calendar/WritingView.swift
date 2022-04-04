//
//  WritingView.swift
//  moeum
//
//  Created by 송영모 on 2022/04/04.
//

import UIKit
import Then

class WritingView: UIView {
    
    var tagTextField = UITextField()
        .then {
            $0.placeholder = "태그를 입력해주세요."
            $0.textColor = .black
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    func setup() {
        self.addSubview(tagTextField)
        tagTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tagTextField.topAnchor.constraint(equalTo: self.topAnchor),
            tagTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tagTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
