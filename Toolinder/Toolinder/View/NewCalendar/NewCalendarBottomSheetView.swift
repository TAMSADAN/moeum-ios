//
//  NewCalendarBottomSheetView.swift
//  Toolinder
//
//  Created by 송영모 on 2022/05/03.
//

import UIKit
import Then

class NewCalendarBottomSheetView: UIView {
    var divider = UIView()
    var titleLabel = UILabel().then {
        $0.font = Const.Font.title3
        $0.text = "임시 날짜"
    }
    var hideButton = UIButton().then {
        $0.setBackgroundImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
    }
    var recordTableView = UITableView().then {
        $0.register(RecordListTableViewCell.self, forCellReuseIdentifier: RecordListTableViewCell.identifier)
        $0.rowHeight = 70
        $0.backgroundColor = .white
        $0.separatorStyle = .none
    }
    var calendarItem: CalendarItem!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        
    }
}

extension NewCalendarBottomSheetView {
    func update(calendarItem: CalendarItem) {
        self.calendarItem = calendarItem
        titleLabel.text = calendarItem.date.getCalendarBottomSheetDateString()
    }
    
    func setView() {
        backgroundColor = Const.Color.white
        
        addSubview(divider)
        addSubview(titleLabel)
        addSubview(hideButton)
        addSubview(recordTableView)
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        hideButton.translatesAutoresizingMaskIntoConstraints = false
        recordTableView.translatesAutoresizingMaskIntoConstraints = false
        hideButton.tintColor = Const.Color.systemGray3
        
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: topAnchor),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 0.5),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
//            hideButton.topAnchor.constraint(equalTo: topAnchor),
            hideButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            hideButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            hideButton.widthAnchor.constraint(equalToConstant: 50),
            hideButton.heightAnchor.constraint(equalToConstant: 30),
            
            recordTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            recordTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            recordTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            recordTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
