//
//  ImageTextField.swift
//  moeum
//
//  Created by 송영모 on 2022/04/06.
//

import UIKit

class ImageTextField: UIView {
    
    var imageString = String()
    var textString = String()
    
    var imageView = UIImageView(image: UIImage(systemName: "tag"))
        .then {
            $0.tintColor = .black
            $0.contentMode = .scaleAspectFit
        }
    
    var textField = UITextField()
        .then {
            $0.attributedPlaceholder = NSAttributedString(string: "태그", attributes: [.foregroundColor: UIColor.black])
            $0.tintColor = .systemBlue
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 15)
            $0.textAlignment = .left
            $0.contentMode = .scaleToFill
            $0.isMultipleTouchEnabled = false
        }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    init(image: String, text: String) {
        super.init(frame: .zero)
        self.imageString = image
        self.textString = text
        self.setup()
    }
    
    func setup() {
        self.addSubview(self.imageView)
        self.imageView.image = UIImage(systemName: self.imageString)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageView.widthAnchor.constraint(equalToConstant: 20),
            self.imageView.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        self.addSubview(self.textField)
        self.textField.attributedPlaceholder = NSAttributedString(string: self.textString, attributes: [.foregroundColor: UIColor.black])
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.textField.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 5),
            self.textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.textField.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor),
        ])
    }
}
