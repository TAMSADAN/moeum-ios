//
//  RecordFixedLabel.swift
//  moeum
//
//  Created by 송영모 on 2022/04/11.
//

import UIKit

class RecordFixedLabel: UIView {
    
    var contentView = UIView()
    
    var tradeLabel = UILabel()
        .then {
            $0.text = "거래"
            $0.font = Const.Font.footnote
            $0.textAlignment = .center
        }
    
    var tagLabel = UILabel()
        .then {
            $0.text = "태그"
            $0.font = Const.Font.footnote
            $0.textAlignment = .center
        }
    
    var itemLabel = UILabel()
        .then {
            $0.text = "종목명"
            $0.font = Const.Font.footnote
            $0.textAlignment = .center
        }
    
    var priceLabel = UILabel()
        .then {
            $0.text = "가격"
            $0.font = Const.Font.footnote
            $0.textAlignment = .right
        }
    
    var countLabel = UILabel()
        .then {
            $0.text = "수량"
            $0.font = Const.Font.footnote
            $0.textAlignment = .right
        }
    
    var incomeLabel = UILabel()
        .then {
            $0.text = "손익"
            $0.font = Const.Font.footnote
            $0.textAlignment = .right
        }
    
    var memoLabel = UILabel()
        .then {
            $0.text = "메모"
            $0.font = Const.Font.footnote
            $0.textAlignment = .center
        }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
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
