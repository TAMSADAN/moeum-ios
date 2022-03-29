//
//  MemoCalendarView.swift
//  moeum
//
//  Created by 송영모 on 2022/03/29.
//

import UIKit

class MemoCalendarView: UIView {
    
    lazy var monthPickerLabel = UILabel()
    lazy var monthPickerButton = UIButton()
    lazy var weekStackView = UIStackView()
    lazy var memoCalendarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    lazy var memoCalendarBottomSheetView = UIView()
    
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    private var calendarDate = Date()
    private var days = [String]()
    private var dates = [Date()]
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configure()
        
        print(self.frame.width)
        print(self.frame.height)
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.configureMonthPickerLabel()
        self.configureMonthPickerButton()
        self.configureWeekStackView()
        self.configureMemoCalendarCollectionView()
        self.configureMemoCalendarBottomSheet()
        self.configureCalendar()
        
        self.configureAutoLayout()
    }
    
    private func configureMonthPickerLabel() {
        self.addSubview(self.monthPickerLabel)
        self.monthPickerLabel.text = "2022.3"
        self.monthPickerLabel.font = .systemFont(ofSize: 20, weight: .bold)
        self.monthPickerLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureMonthPickerButton() {
        self.addSubview(self.monthPickerButton)
        self.monthPickerButton.setBackgroundImage(UIImage(systemName: "chevron.down"), for: .normal)
        self.monthPickerButton.tintColor = .black
        self.monthPickerButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureWeekStackView() {
        self.addSubview(self.weekStackView)
        self.weekStackView.distribution = .fillEqually
        self.weekStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for day in ["일", "월", "화", "수", "목", "금", "토"] {
            let label = UILabel()
            label.text = day
            label.font = .systemFont(ofSize: 13)
            if day == "일" {
                label.textColor = .systemRed
            } else if day == "토" {
                label.textColor = .systemBlue
            }
            label.textAlignment = .center
            self.weekStackView.addArrangedSubview(label)
        }
    }
    
    private func configureMemoCalendarCollectionView() {
        self.addSubview(self.memoCalendarCollectionView)
        self.memoCalendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.memoCalendarCollectionView.dataSource = self
        self.memoCalendarCollectionView.delegate = self
        self.memoCalendarCollectionView.register(MemoCalendarCollectionViewCell.self, forCellWithReuseIdentifier: MemoCalendarCollectionViewCell.identifier)
    }
    
    private func configureMemoCalendarBottomSheet() {
        self.addSubview(self.memoCalendarBottomSheetView)
        self.memoCalendarBottomSheetView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureAutoLayout() {
        NSLayoutConstraint.activate([
            self.monthPickerLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.monthPickerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            self.monthPickerButton.leadingAnchor.constraint(equalTo: self.monthPickerLabel.trailingAnchor, constant: 5),
            self.monthPickerButton.centerYAnchor.constraint(equalTo: self.monthPickerLabel.centerYAnchor),
            self.monthPickerButton.widthAnchor.constraint(equalToConstant: 20),
            self.monthPickerButton.heightAnchor.constraint(equalToConstant: 20),
            
            self.weekStackView.topAnchor.constraint(equalTo: self.monthPickerLabel.bottomAnchor, constant: 10),
            self.weekStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.weekStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.memoCalendarCollectionView.topAnchor.constraint(equalTo: self.weekStackView.bottomAnchor),
            self.memoCalendarCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.memoCalendarCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.memoCalendarCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

extension MemoCalendarView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {

        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemoCalendarCollectionViewCell.identifier, for: indexPath) as? MemoCalendarCollectionViewCell else { return UICollectionViewCell()}
        cell.update(date: self.dates[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.weekStackView.frame.width / 7
//        let height = self.collectionView.frame.height / 5
        return CGSize(width: width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}

extension MemoCalendarView {
    
    private func configureCalendar() {
        self.dateFormatter.dateFormat = "yyyy.M"
        self.today()
    }
    
    private func startDayOfTheWeek() -> Int {
        return self.calendar.component(.weekday, from: self.calendarDate) - 1
    }
    
    private func endDate() -> Int {
        return self.calendar.range(of: .day, in: .month, for: self.calendarDate)?.count ?? Int()
    }
    
    private func updateCalendar() {
        self.updateTitle()
        self.updateDays()
    }
    
    private func updateTitle() {
        let date = self.dateFormatter.string(from: self.calendarDate)
    }
    
    private func updateDays() {
        self.days.removeAll()
        self.dates.removeAll()
        let startDayOfTheWeek = self.startDayOfTheWeek()
        let totalDays = startDayOfTheWeek + self.endDate()
        
        for day in Int()..<totalDays {
            if day < startDayOfTheWeek {
                self.days.append(String())
                self.dates.append(Date(timeIntervalSince1970: 0))
                continue
            }
            var dateComponents = DateComponents()
            dateComponents.year = self.calendar.component(.year, from: self.calendarDate)
            dateComponents.month = self.calendar.component(.month, from: self.calendarDate)
            dateComponents.day = day
            dateComponents.hour = -10
            dateComponents.timeZone = TimeZone(abbreviation: "UTC")
            self.days.append("\(day - startDayOfTheWeek + 1)")
            self.dates.append(self.calendar.date(from: dateComponents) ?? Date())
            
        }
        self.memoCalendarCollectionView.reloadData()
    }
    
    private func minusMonth() {
        self.calendarDate = self.calendar.date(byAdding: DateComponents(month: -1), to: self.calendarDate) ?? Date()
        self.updateCalendar()
    }
    
    private func plusMonth() {
        self.calendarDate = self.calendar.date(byAdding: DateComponents(month: 1), to: self.calendarDate) ?? Date()
        self.updateCalendar()
    }
    
    private func today() {
        let components = self.calendar.dateComponents([.year, .month], from: Date())
        self.calendarDate = self.calendar.date(from: components) ?? Date()
        self.updateCalendar()
    }
}
