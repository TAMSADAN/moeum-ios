//
//  RecordZipContentTableViewCell.swift
//  Toolinder
//
//  Created by 송영모 on 2022/05/05.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    static let identifier = "RecordTableViewCell"
    var recordZip: RecordZip!
    var record: Record!
    
    var typeView = UIView().then {
            $0.layer.cornerRadius = 15
            $0.backgroundColor = Const.Color.pink
        }
    var typeImageView = UIImageView().then {
            $0.image = UIImage(systemName: "airplane.departure")
            $0.tintColor = Const.Color.white
        }
    var itemLabel = UILabel().then {
            $0.font = Const.Font.itemHeadline
            $0.textColor = Const.Color.black
            $0.text = "비트코인"
        }
    var tagLabel = UILabel().then {
            $0.font = Const.Font.itemFootnote
            $0.textColor = Const.Color.darkGray
            $0.text = "코인"
        }
    var memoTextField = UILabel().then {
        $0.font = Const.Font.itemFootnote
        $0.textColor = Const.Color.darkGray
        $0.numberOfLines = 3
        $0.text = "as"
    }
    var dateLabel = UILabel().then {
            $0.font = Const.Font.itemFootnote
            $0.textColor = .darkGray
            $0.text = "2022-04-22T09:35:59"
        }
    var countLabel = UILabel().then {
            $0.font = Const.Font.itemFootnote
            $0.textColor = .darkGray
            $0.text = "3개"
        }
    var priceLabel = UILabel().then {
            $0.font = Const.Font.itemFootnote
            $0.textColor = .darkGray
            $0.text = "20,845원"
        }
    var typeLabel = UILabel().then {
        $0.font = Const.Font.itemHeadline
        $0.text = "매수"
        $0.textColor = Const.Color.buy
    }
    var sumLabel = UILabel().then {
            $0.font = Const.Font.itemHeadline
            $0.text = "691,866원"
        }
    var divider = UIView().then {
            $0.backgroundColor = Const.Color.white
        }
    var nextTradeLabel = UILabel().then {
        $0.font = Const.Font.itemFootnote
        $0.textColor = Const.Color.black
        $0.text = "거래후"
    }
    var nextPriceLabel = UILabel().then {
        $0.font = Const.Font.itemFootnote
        $0.textColor = Const.Color.black
        $0.text = "평균 단가 47,000원"
    }
    var nextCountLabel = UILabel().then {
        $0.font = Const.Font.itemFootnote
        $0.textColor = Const.Color.black
        $0.text = "보유 수량 47개"
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    
    func update(recordZip: RecordZip, record: Record) {
        self.recordZip = recordZip
        self.record = record
        
        let (buyAvgPrice, buyCount) = recordZip.getBuyDataAt(record: record)
        
        itemLabel.text = record.item
        tagLabel.text = record.tag + " "
        dateLabel.text = record.date.getString()
        sumLabel.text = String(Int(record.price * record.count)).insertComma + "원 "
        priceLabel.text = "단가 " + String(Int(record.price * 100) / 100).insertComma + "원"
        countLabel.text = "수량 " + String(Int(record.count * 100) / 100).insertComma + "개"
        
        nextCountLabel.text = "보유 수량 " + String(Int(buyCount)).insertComma + "개"
        
        if record.type == "매수" {
            typeImageView.image = UIImage(systemName: "airplane.departure")
            typeView.backgroundColor = Const.Color.buy
            typeLabel.text = "매수"
            typeLabel.textColor = Const.Color.buy
            nextPriceLabel.text = "평균 단가 " + String(Int(buyAvgPrice)).insertComma
        } else if record.type == "매도" {
            typeImageView.image = UIImage(systemName: "airplane.arrival")
            typeView.backgroundColor = Const.Color.sell
            typeLabel.text = "매도"
            typeLabel.textColor = Const.Color.sell
            nextPriceLabel.text = "실현 손익 " + String(Int(recordZip.getProfitPriceAt(record: record))).insertComma + "원"
        } else {
            typeImageView.image = UIImage(systemName: "paperclip")
            typeView.backgroundColor = Const.Color.purple
        }
        
        memoTextField.text = record.memo
    }
    
    
    func setView() {
        backgroundColor = Const.Color.white
        
        let itemContainer = UILayoutGuide()
        let priceContainer = UILayoutGuide()
        
        addLayoutGuide(itemContainer)
        addLayoutGuide(priceContainer)
        
        addSubview(typeView)
        addSubview(typeImageView)
        addSubview(itemLabel)
        addSubview(tagLabel)
        addSubview(memoTextField)
        addSubview(dateLabel)
        addSubview(priceLabel)
        addSubview(typeLabel)
        addSubview(sumLabel)
        addSubview(countLabel)
        addSubview(divider)
        addSubview(nextTradeLabel)
        addSubview(nextPriceLabel)
        addSubview(nextCountLabel)
        
        typeView.translatesAutoresizingMaskIntoConstraints = false
        typeImageView.translatesAutoresizingMaskIntoConstraints = false
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        memoTextField.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        sumLabel.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        nextTradeLabel.translatesAutoresizingMaskIntoConstraints = false
        nextPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        nextCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            typeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            typeView.centerYAnchor.constraint(equalTo: itemContainer.centerYAnchor),
            typeView.heightAnchor.constraint(equalToConstant: 30),
            typeView.widthAnchor.constraint(equalToConstant: 30),
            
            typeImageView.topAnchor.constraint(equalTo: typeView.topAnchor, constant: 5),
            typeImageView.leadingAnchor.constraint(equalTo: typeView.leadingAnchor, constant: 5),
            typeImageView.trailingAnchor.constraint(equalTo: typeView.trailingAnchor, constant: -5),
            typeImageView.bottomAnchor.constraint(equalTo: typeView.bottomAnchor, constant: -5),
            
            itemContainer.topAnchor.constraint(equalTo: priceContainer.topAnchor),
            itemContainer.leadingAnchor.constraint(equalTo: typeView.trailingAnchor, constant: 10),
            itemContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -40),
            
            itemLabel.topAnchor.constraint(equalTo: itemContainer.topAnchor),
            itemLabel.leadingAnchor.constraint(equalTo: itemContainer.leadingAnchor),
            
            tagLabel.topAnchor.constraint(equalTo: itemLabel.bottomAnchor),
            tagLabel.leadingAnchor.constraint(equalTo: itemContainer.leadingAnchor),
            
            memoTextField.topAnchor.constraint(equalTo: tagLabel.bottomAnchor),
            memoTextField.leadingAnchor.constraint(equalTo: itemContainer.leadingAnchor),
            memoTextField.trailingAnchor.constraint(equalTo: itemContainer.trailingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: memoTextField.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: itemContainer.leadingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: itemContainer.bottomAnchor),
            
            priceContainer.leadingAnchor.constraint(equalTo: itemContainer.trailingAnchor),
            priceContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            priceContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            sumLabel.topAnchor.constraint(equalTo: priceContainer.topAnchor),
            sumLabel.trailingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
            
            typeLabel.bottomAnchor.constraint(equalTo: sumLabel.bottomAnchor),
            typeLabel.trailingAnchor.constraint(equalTo: priceContainer.trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: sumLabel.bottomAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: priceContainer.trailingAnchor),
            
            countLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            countLabel.trailingAnchor.constraint(equalTo: priceContainer.trailingAnchor),
            
            nextTradeLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor),
            nextTradeLabel.trailingAnchor.constraint(equalTo: priceContainer.trailingAnchor),
            
            nextPriceLabel.topAnchor.constraint(equalTo: nextTradeLabel.bottomAnchor),
            nextPriceLabel.trailingAnchor.constraint(equalTo: priceContainer.trailingAnchor),
            
            nextCountLabel.topAnchor.constraint(equalTo: nextPriceLabel.bottomAnchor),
            nextCountLabel.trailingAnchor.constraint(equalTo: priceContainer.trailingAnchor),
            nextCountLabel.bottomAnchor.constraint(equalTo: priceContainer.bottomAnchor),
        ])
    }
}
