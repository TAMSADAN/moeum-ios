//
//  ListViewCell.swift
//  Toolinder
//
//  Created by 송영모 on 2022/04/25.
//

import UIKit
import Then

class ListTableViewCell: UITableViewCell {
    static let identifier = "ListTableViewCell"
    var listItemModel: ListItemModel!
    
    var typeView = UIView()
        .then {
            $0.layer.cornerRadius = 15
            $0.backgroundColor = .systemPink
        }
    
    var typeImageView = UIImageView()
        .then {
            $0.image = UIImage(systemName: "airplane.departure")
            $0.tintColor = .white
        }
    
    var itemLabel = UILabel()
        .then {
            $0.font = Const.Font.itemHeadline
            $0.text = "비트코인"
        }
    
    var tagLabel = UILabel()
        .then {
            $0.font = Const.Font.itemFootnote
            $0.textColor = .darkGray
            $0.text = "코인"
        }
    
    var dateLabel = UILabel()
        .then {
            $0.font = Const.Font.itemFootnote
            $0.textColor = .darkGray
            $0.text = "2022-04-22T09:35:59"
        }
    
    
    var countLabel = UILabel()
        .then {
            $0.font = Const.Font.itemFootnote
            $0.textColor = .darkGray
            $0.text = "3개"
        }
    
    var priceLabel = UILabel()
        .then {
            $0.font = Const.Font.itemFootnote
            $0.textColor = .darkGray
            $0.text = "20,845원"
        }
    
    var sumLabel = UILabel()
        .then {
            $0.font = Const.Font.itemHeadline
            $0.text = "691,866원"
        }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    
    func update(listItemModel: ListItemModel) {
        self.listItemModel = listItemModel
        itemLabel.text = listItemModel.item
        tagLabel.text = listItemModel.tag + " "
        dateLabel.text = listItemModel.date
        
        var sumLabelText = ""
        let sumDefaultLabelText = "\(listItemModel.sum.insertComma)원"
        var sumGapLabelText = ""
        var hightlightColor = Const.Color.orange
        if !listItemModel.sumGap.contains("-") {
            sumGapLabelText = "(+\(listItemModel.sumGap.insertComma)원)"
        } else {
            sumGapLabelText = "(\(listItemModel.sumGap.insertComma)원)"
            hightlightColor = Const.Color.indigo
        }
        
        if listItemModel.type == "매수" {
            sumLabelText = sumDefaultLabelText
        } else if listItemModel.type == "매도" {
            sumLabelText = sumDefaultLabelText + " " + sumGapLabelText
        }
        
        let sumLabelAttriHighlightRange = (sumLabelText as NSString).range(of: sumGapLabelText)
        let sumLabelAttriDefaultRange = (sumLabelText as NSString).range(of: sumDefaultLabelText)
        let sumLabelAttriString = NSMutableAttributedString(string: sumLabelText)
        
        sumLabelAttriString.addAttributes([.foregroundColor: hightlightColor, .font: Const.Font.itemHeadline], range: sumLabelAttriHighlightRange)
        sumLabelAttriString.addAttributes([.foregroundColor: UIColor.black, .font: Const.Font.itemHeadline], range: sumLabelAttriDefaultRange)
//        let sumLabelAttriString = NSMutableAttributedString(string: sumLabelText, attributes: [NSMutableAttributedString.Key.font: Const.Font.itemHeadline, NSMutableAttributedString.Key.foregroundColor: Const.Color.mint])
        
//        sumLabelAttriString.addAttribute(NSAttributedString.Key.font, value: Const.Font.title1, range: sumLabelAttriRange)
        
//        sumLabel.text = "\(listItemModel.sum.insertComma)원 (\(listItemModel.sumGap.insertComma)원)"
        sumLabel.attributedText = sumLabelAttriString
        priceLabel.text = listItemModel.price.insertComma + "원"
        countLabel.text = listItemModel.count.insertComma + "개"
        
        let attributedStr = NSMutableAttributedString(string: sumLabel.text!)
        
        if listItemModel.type == "매수" {
            typeImageView.image = UIImage(systemName: "airplane.departure")
//            attributedStr.addAttribute(.font, value: font, range: (text as String).range(of: "Zedd"))
            typeView.backgroundColor = Const.Color.pink
        } else if listItemModel.type == "매도" {
            typeImageView.image = UIImage(systemName: "airplane.arrival")
            typeView.backgroundColor = Const.Color.mint
        } else {
            typeImageView.image = UIImage(systemName: "paperclip")
            typeView.backgroundColor = Const.Color.purple
        }
//        self.record = record
//
//        itemLabel.text = record.item
//        tagLabel.text = record.tag
//        dateLabel.text = record.date.getString()
//
//        sumLabel.text = String(record.price * record.count).insertComma + "원"
//        priceLabel.text = String(record.price).insertComma + "원"
//        countLabel.text = String(record.count).insertComma + "개"
//
//        if record.type == "매수" {
//            typeImageView.image = UIImage(systemName: "airplane.departure")
//            typeView.backgroundColor = Const.Color.pink
//        } else if record.type == "매도" {
//            typeImageView.image = UIImage(systemName: "airplane.arrival")
//            typeView.backgroundColor = Const.Color.mint
//        }
    }
    
    
    func setView() {
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
        
        typeView.translatesAutoresizingMaskIntoConstraints = false
        typeImageView.translatesAutoresizingMaskIntoConstraints = false
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        sumLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            typeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
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
            
            priceContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            priceContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            sumLabel.topAnchor.constraint(equalTo: priceContainer.topAnchor),
            sumLabel.trailingAnchor.constraint(equalTo: priceContainer.trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: sumLabel.bottomAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: priceContainer.trailingAnchor),
            
            countLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            countLabel.trailingAnchor.constraint(equalTo: priceContainer.trailingAnchor),
            countLabel.bottomAnchor.constraint(equalTo: priceContainer.bottomAnchor),
        ])
    }

}
