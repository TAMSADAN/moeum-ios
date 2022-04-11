//
//  RecordLabel.swift
//  moeum
//
//  Created by 송영모 on 2022/04/11.
//

import UIKit

class RecordLabel: UIView {
    
    var contentView = UIView()
    
    var tradeLabel = UILabel()
        .then {
            $0.text = "매수"
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
        contentView.addSubview(tradeLabel)
        contentView.addSubview(tagLabel)
        contentView.addSubview(itemLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(incomeLabel)
        
        tagLabel.text = record.tag
        itemLabel.text = record.item
        priceLabel.text = String(record.price)
        countLabel.text = String(record.count)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        tradeLabel.translatesAutoresizingMaskIntoConstraints = false
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
            
            tradeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            tradeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tradeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tradeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1),
            
            tagLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagLabel.leadingAnchor.constraint(equalTo: tradeLabel.trailingAnchor),
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
