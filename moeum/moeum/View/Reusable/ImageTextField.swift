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
    
    var captionLabel = UILabel()
        .then {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 9, weight: .semibold)
        }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    init(image: String, text: String) {
        super.init(frame: .zero)
        self.imageString = image
        self.textString = text
        setup()
    }
    
    func setup() {
        addSubview(imageView)
        addSubview(textField)
        addSubview(captionLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(systemName: imageString)
        textField.attributedPlaceholder = NSAttributedString(string: textString, attributes: [.foregroundColor: UIColor.black])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            
            textField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            captionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 2),
            captionLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            captionLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
        ])
    }
}
