//
//  ImageLabel.swift
//  moeum
//
//  Created by 송영모 on 2022/04/06.
//

import UIKit

class ImageLabel: UIView {

    var imageString = String()
    var labelString = String()
    
    var imageView = UIImageView(image: UIImage(systemName: "tag"))
        .then {
            $0.tintColor = .black
            $0.contentMode = .scaleAspectFit
        }
    
    var label = UILabel()
        .then {
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
    
    init(image: String, label: String) {
        super.init(frame: .zero)
        self.imageString = image
        self.labelString = label
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
        
        self.addSubview(self.label)
        self.label.text = self.labelString
        self.label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.label.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 5),
            self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.label.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor),
        ])
    }

}
