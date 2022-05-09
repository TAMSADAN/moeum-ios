//
//  RecordZipTableViewCell.swift
//  Toolinder
//
//  Created by 송영모 on 2022/05/05.
//

import UIKit
import Then

class RecordZipTableViewCell: UITableViewCell {
    static let identifier = "RecordZipTitleTableViewCell"
    var recordZip: RecordZip!
    
    var typeView = UIView().then {
            $0.layer.cornerRadius = 15
            $0.backgroundColor = Const.Color.orange
        }
    var typeImageView = UIImageView().then {
            $0.image = UIImage(systemName: "shippingbox")
            $0.tintColor = Const.Color.white
        }
    var itemLabel = UILabel().then {
            $0.font = Const.Font.itemHeadline
            $0.text = "비트코인"
        }
    var tagLabel = UILabel().then {
            $0.font = Const.Font.itemFootnote
            $0.textColor = .darkGray
            $0.text = "코인"
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
    var sumLabel = UILabel().then {
            $0.font = Const.Font.itemHeadline
            $0.text = "691,866원"
        }
    var nextImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = Const.Color.black
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
}

extension RecordZipTableViewCell {
    func update(recordZip: RecordZip) {
        self.recordZip = recordZip
        
        let (buyPriceAvg, buyCount) = recordZip.getBuyDataAt(record: recordZip.records.first ?? Record())
        
        itemLabel.text = recordZip.record.item
        tagLabel.text = recordZip.record.tag
        priceLabel.text = "평균 단가 " + String(Int(buyPriceAvg)).insertComma + "원"
        countLabel.text = "보유 수량 " + String(Int(buyCount)).insertComma + "개"
        dateLabel.text = (recordZip.records.first ?? Record()).date.getString()
        
        let profitPriceSum = recordZip.getProfitPriceSum()
        var sumLabelText = String(Int(profitPriceSum)).insertComma + "원 "
        
        if !recordZip.records.contains(where: { $0.type == "매도" }) {
            typeView.backgroundColor = Const.Color.pink
            sumLabel.text = "매수만 했습니다"
        } else if !recordZip.records.contains(where: { $0.type == "매수" }) {
            typeView.backgroundColor = Const.Color.black
            sumLabel.text = "매수 기록이 없는데 매도 기록이 있습니다"
        } else if profitPriceSum >= 0 {
            typeView.backgroundColor = Const.Color.orange
            sumLabelText += "이득"
            let sumLabelAttriRange = (sumLabelText as NSString).range(of: "이득")
            let sumLabelAttriString = NSMutableAttributedString(string: sumLabelText)
            sumLabelAttriString.addAttributes([.foregroundColor: Const.Color.orange, .font: Const.Font.itemHeadline], range: sumLabelAttriRange)
            sumLabel.attributedText = sumLabelAttriString
        } else if profitPriceSum < 0 {
            typeView.backgroundColor = Const.Color.indigo
            sumLabelText += "손해"
            let sumLabelAttriRange = (sumLabelText as NSString).range(of: "손해")
            let sumLabelAttriString = NSMutableAttributedString(string: sumLabelText)
            sumLabelAttriString.addAttributes([.foregroundColor: Const.Color.indigo, .font: Const.Font.itemHeadline], range: sumLabelAttriRange)
            sumLabel.attributedText = sumLabelAttriString
        }
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
        addSubview(dateLabel)
        addSubview(priceLabel)
        addSubview(sumLabel)
        addSubview(countLabel)
        addSubview(nextImageView)
        
        typeView.translatesAutoresizingMaskIntoConstraints = false
        typeImageView.translatesAutoresizingMaskIntoConstraints = false
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        sumLabel.translatesAutoresizingMaskIntoConstraints = false
        nextImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            typeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            typeView.centerYAnchor.constraint(equalTo: centerYAnchor),
            typeView.heightAnchor.constraint(equalToConstant: 30),
            typeView.widthAnchor.constraint(equalToConstant: 30),
            
            typeImageView.topAnchor.constraint(equalTo: typeView.topAnchor, constant: 5),
            typeImageView.leadingAnchor.constraint(equalTo: typeView.leadingAnchor, constant: 5),
            typeImageView.trailingAnchor.constraint(equalTo: typeView.trailingAnchor, constant: -5),
            typeImageView.bottomAnchor.constraint(equalTo: typeView.bottomAnchor, constant: -5),
            
            itemContainer.leadingAnchor.constraint(equalTo: typeView.trailingAnchor, constant: 10),
            itemContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            itemLabel.topAnchor.constraint(equalTo: itemContainer.topAnchor),
            itemLabel.leadingAnchor.constraint(equalTo: itemContainer.leadingAnchor),
            
            tagLabel.topAnchor.constraint(equalTo: itemLabel.bottomAnchor),
            tagLabel.leadingAnchor.constraint(equalTo: itemContainer.leadingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: tagLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: itemContainer.leadingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: itemContainer.bottomAnchor),
            
            priceContainer.trailingAnchor.constraint(equalTo: nextImageView.leadingAnchor, constant: -10),
            priceContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            sumLabel.topAnchor.constraint(equalTo: priceContainer.topAnchor),
            sumLabel.trailingAnchor.constraint(equalTo: priceContainer.trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: sumLabel.bottomAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: priceContainer.trailingAnchor),
            
            countLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            countLabel.trailingAnchor.constraint(equalTo: priceContainer.trailingAnchor),
            countLabel.bottomAnchor.constraint(equalTo: priceContainer.bottomAnchor),
            
            nextImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

extension RecordZipTableViewCell {
    func show() {
        
    }
    
    func hide() {
        
    }
}
