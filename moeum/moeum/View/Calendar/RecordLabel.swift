//
//  RecordLabel.swift
//  moeum
//
//  Created by 송영모 on 2022/04/11.
//

import UIKit

class RecordLabel: UIView {
    
    var contentView = UIView()
    
    var typeLabel = UILabel()
        .then {
            $0.font = Const.Font.footnote
            $0.textAlignment = .center
            $0.adjustsFontSizeToFitWidth = true
        }
    
    var tagLabel = UILabel()
        .then {
            $0.font = Const.Font.footnote
            $0.textAlignment = .center
            $0.adjustsFontSizeToFitWidth = true
        }
    
    var itemLabel = UILabel()
        .then {
            $0.font = Const.Font.footnote
            $0.textAlignment = .center
            $0.adjustsFontSizeToFitWidth = true
        }
    
    var priceLabel = UILabel()
        .then {
            $0.font = Const.Font.footnote
            $0.textAlignment = .right
            $0.adjustsFontSizeToFitWidth = true
        }
    
    var countLabel = UILabel()
        .then {
            $0.font = Const.Font.footnote
            $0.textAlignment = .right
            $0.adjustsFontSizeToFitWidth = true
        }
    
    var incomeLabel = UILabel()
        .then {
            $0.font = Const.Font.footnote
            $0.textAlignment = .right
            $0.adjustsFontSizeToFitWidth = true
        }
    
    var record: Record!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    init(record: Record) {
        super.init(frame: .zero)
        self.record = record
        setView()
    }
    
    func setView() {
        addSubview(contentView)
        contentView.addSubview(typeLabel)
        contentView.addSubview(tagLabel)
        contentView.addSubview(itemLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(incomeLabel)
        
        if record.type == "매수" {
            typeLabel.textColor = .systemRed
        } else if record.type == "매도" {
            typeLabel.textColor = .systemBlue
        } else {
            typeLabel.textColor = .black
        }
        
        typeLabel.text = record.type
        tagLabel.text = record.tag
        itemLabel.text = record.item
        priceLabel.text = String(record.price)
        countLabel.text = String(record.count)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        incomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 20),
            
            typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            typeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            typeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1),
            
            tagLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagLabel.leadingAnchor.constraint(equalTo: typeLabel.trailingAnchor),
            tagLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tagLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
            
            itemLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemLabel.leadingAnchor.constraint(equalTo: tagLabel.trailingAnchor),
            itemLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            itemLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
            
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: itemLabel.trailingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            priceLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            
            countLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            countLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor),
            countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            countLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            
            incomeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            incomeLabel.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor, constant: -5),
            incomeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            incomeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
        ])
    }
}
