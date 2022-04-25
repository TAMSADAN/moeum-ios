//
//  CircleImageView.swift
//  Toolinder
//
//  Created by 송영모 on 2022/04/25.
//

import UIKit
import Then

class CircleImageView: UIView {
    
    var size = CGFloat()

    var circleView = UIView()
    
    var imageView = UIImageView()
        .then {
            $0.tintColor = .white
        }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(image: UIImage, color: UIColor, size: CGFloat) {
        super.init(frame: .zero)
        self.size = size
        
        circleView.backgroundColor = color
        circleView.layer.cornerRadius = size / 2
        
        imageView.image = image
        setView()
    }
    
    func setView() {
        addSubview(circleView)
        addSubview(imageView)
        
        circleView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: topAnchor),
            circleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            circleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            circleView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: circleView.topAnchor, constant: self.size / 6),
            imageView.leadingAnchor.constraint(equalTo: circleView.leadingAnchor, constant: self.size / 6),
            imageView.trailingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: -(self.size / 6)),
            imageView.bottomAnchor.constraint(equalTo: circleView.bottomAnchor, constant: -(self.size / 6)),
        ])
    }
}
