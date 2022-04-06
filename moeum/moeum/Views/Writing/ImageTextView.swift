//
//  ImageTextView.swift
//  moeum
//
//  Created by 송영모 on 2022/04/06.
//

import UIKit

class ImageTextView: UIView {
    
    var imageString = String()
    var textString = String()
    
    var imageView = UIImageView(image: UIImage(systemName: "tag"))
        .then {
            $0.tintColor = .black
            $0.contentMode = .scaleAspectFit
        }
    
    var textView = UITextView()
        .then {
            $0.text = "메모"
            $0.tintColor = .systemBlue
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 15)
            $0.textAlignment = .left
            $0.isMultipleTouchEnabled = false
            $0.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
        
        self.addSubview(self.textView)
        self.textView.translatesAutoresizingMaskIntoConstraints = false
//        self.textView.backgroundColor = .red
        NSLayoutConstraint.activate([
            self.textView.topAnchor.constraint(equalTo: self.topAnchor),
            self.textView.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor),
            self.textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.textView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
