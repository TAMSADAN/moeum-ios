//
//  MemoCalendarViewController+UI.swift
//  moeum
//
//  Created by 송영모 on 2022/03/30.
//

import UIKit

extension MemoCalendarViewController {
    
    func setup() {
        self.setupViews()
        self.setupLayouts()
    }
    
    func hideMemoCalendarCollectionView() {
        self.memoCalendarCollectionViewTopConstraint.constant = self.memoCalendarCollectionViewHideTopConstant * -1
        UIView.animate(withDuration: 0.5,
                       animations: {
            self.contentView.layoutIfNeeded()
            self.memoCalendarCollectionView.performBatchUpdates(nil)
            }
        )
    }
    
    func showMemoCalendarCollectionView() {
        
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        self.setupContentView()
        self.setupMonthPickerLabel()
        self.setupMonthPickerButton()
        self.setupWeekStackView()
        self.configureCalendar()
        self.setupMemoCalendarCollectionView()
    }
    
    private func setupContentView() {
        self.view.addSubview(self.contentView)
        self.contentView.backgroundColor = .white
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupMonthPickerLabel() {
        self.contentView.addSubview(self.monthPickerLabel)
        self.monthPickerLabel.text = "2022.3"
        self.monthPickerLabel.font = .systemFont(ofSize: 20, weight: .bold)
        self.monthPickerLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupMonthPickerButton() {
        self.contentView.addSubview(self.monthPickerButton)
        self.monthPickerButton.setBackgroundImage(UIImage(systemName: "chevron.down"), for: .normal)
        self.monthPickerButton.tintColor = .black
        self.monthPickerButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupWeekStackView() {
        self.contentView.addSubview(self.weekStackView)
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
    
    private func setupMemoCalendarCollectionView() {
        self.contentView.addSubview(self.memoCalendarCollectionView)
        self.memoCalendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.memoCalendarCollectionView.dataSource = self
        self.memoCalendarCollectionView.delegate = self
        self.memoCalendarCollectionView.register(MemoCalendarCollectionViewCell.self, forCellWithReuseIdentifier: MemoCalendarCollectionViewCell.identifier)
    }
    
    
    private func setupLayouts() {
        
        self.memoCalendarCollectionViewTopConstraint = self.memoCalendarCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),

            self.monthPickerLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.monthPickerLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),

            self.monthPickerButton.leadingAnchor.constraint(equalTo: self.monthPickerLabel.trailingAnchor, constant: 5),
            self.monthPickerButton.centerYAnchor.constraint(equalTo: self.monthPickerLabel.centerYAnchor),
            self.monthPickerButton.widthAnchor.constraint(equalToConstant: 20),
            self.monthPickerButton.heightAnchor.constraint(equalToConstant: 20),

            self.weekStackView.topAnchor.constraint(equalTo: self.monthPickerLabel.bottomAnchor, constant: 10),
            self.weekStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.weekStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),

            self.memoCalendarCollectionView.topAnchor.constraint(equalTo: self.weekStackView.bottomAnchor),
            self.memoCalendarCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.memoCalendarCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.memoCalendarCollectionViewTopConstraint,
        ])
        
    }
    
    @objc func openBottomSheet() {
        self.memoCalendarBottomSheetViewController = MemoCalendarBottomSheetViewController(constant: self.memoCalendarBottomSheetDefaultTopConstant)
        self.memoCalendarBottomSheetViewController.modalPresentationStyle = .overFullScreen
        self.present(self.memoCalendarBottomSheetViewController, animated: false, completion: nil)
        self.hideMemoCalendarCollectionView()
        
        print(self.view.frame.height)
        print(self.memoCalendarCollectionView.frame.height)
        print(self.memoCalendarBottomSheetViewController.contentView.frame.height)
    }
}

extension MemoCalendarViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        openBottomSheet()
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemoCalendarCollectionViewCell.identifier, for: indexPath) as? MemoCalendarCollectionViewCell else { return UICollectionViewCell()}
        cell.update(date: self.dates[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.weekStackView.frame.width / 7
        let height = self.memoCalendarCollectionView.frame.height / 5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}

extension MemoCalendarViewController {
    
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

