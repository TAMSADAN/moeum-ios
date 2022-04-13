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
        self.memoCalendarCollectionViewTopConstraint.constant = self.memoCalendarBottomSheetDefaultHeight * -1
        self.memoCalendarBottomSheetViewHeightConstraint.constant = self.memoCalendarBottomSheetDefaultHeight
        UIView.animate(withDuration: 0.5,
                       animations: {
            self.contentView.layoutIfNeeded()
            self.memoCalendarCollectionView.performBatchUpdates(nil)
        }
        )
        self.memoCalendarBottomSheetView.setup()
    }
    
    func showMemoCalendarCollectionView() {
        self.memoCalendarCollectionViewTopConstraint.constant = 0
        self.memoCalendarBottomSheetViewHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.5,
                       animations: {
            self.contentView.layoutIfNeeded()
            self.memoCalendarCollectionView.performBatchUpdates(nil)
        }
        )
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        self.setupContentView()
        self.setupMonthPickerView()
        self.setupCalendarButton()
        self.setupChartButton()
        self.setupWeekStackView()
        self.configureCalendar()
        self.setupMemoCalendarCollectionView()
        self.setupMemoCalendarBottomSheetView()
        self.setupCreateMemoButton()
    }
    
    private func setupContentView() {
        self.view.addSubview(self.contentView)
        self.contentView.backgroundColor = .white
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupMonthPickerView() {
        self.contentView.addSubview(self.monthPickerView)
        self.monthPickerView.translatesAutoresizingMaskIntoConstraints = false
        self.monthPickerView.setup()
    }
    private func setupCalendarButton() {
        self.contentView.addSubview(self.calendarButton)
        self.calendarButton.translatesAutoresizingMaskIntoConstraints = false
        self.calendarButton.setImage(UIImage(systemName: "calendar"), for: .normal)
        self.calendarButton.tintColor = .black
    }
    
    private func setupChartButton() {
        self.contentView.addSubview(self.chartButton)
        self.chartButton.translatesAutoresizingMaskIntoConstraints = false
        self.chartButton.setImage(UIImage(systemName: "chart.pie"), for: .normal)
        self.chartButton.tintColor = .black
        self.chartButton.addTarget(self, action: #selector(onClickChartButton), for: .touchUpInside)
    }
    
    private func setupWeekStackView() {
        self.contentView.addSubview(self.weekView)
        self.weekView.translatesAutoresizingMaskIntoConstraints = false
        self.weekView.setup()
    }
    
    private func setupMemoCalendarCollectionView() {
        self.contentView.addSubview(self.memoCalendarCollectionView)
        self.memoCalendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.memoCalendarCollectionView.dataSource = self
        self.memoCalendarCollectionView.delegate = self
        self.memoCalendarCollectionView.register(MemoCalendarCollectionViewCell.self, forCellWithReuseIdentifier: MemoCalendarCollectionViewCell.identifier)
    }
    
    private func setupMemoCalendarBottomSheetView() {
        self.contentView.addSubview(self.memoCalendarBottomSheetView)
        self.memoCalendarBottomSheetView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupCreateMemoButton() {
        self.contentView.addSubview(self.createButton)
        self.createButton.translatesAutoresizingMaskIntoConstraints = false
        self.createButton.addTarget(self, action: #selector(onClickCreateButton), for: .touchUpInside)
        self.createButton.tintColor = .white
        self.createButton.backgroundColor = .black
        self.createButton.layer.cornerRadius = 23
        self.createButton.setImage(UIImage(systemName: "plus"), for: .normal)
        self.createButton.contentHorizontalAlignment = .fill
        self.createButton.contentVerticalAlignment = .fill
        self.createButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.createButton.layer.shadowColor = UIColor.gray.cgColor
        self.createButton.layer.shadowOpacity = 1.0
        self.createButton.layer.shadowOffset = CGSize.zero
        self.createButton.layer.shadowRadius = 5
    }
    
    private func setupLayouts() {
        self.memoCalendarCollectionViewTopConstraint = self.memoCalendarCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        self.memoCalendarBottomSheetViewHeightConstraint = self.memoCalendarBottomSheetView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            self.monthPickerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.monthPickerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.monthPickerView.heightAnchor.constraint(equalToConstant: 20),
            
            self.chartButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.chartButton.centerYAnchor.constraint(equalTo: self.monthPickerView.centerYAnchor),
            self.chartButton.widthAnchor.constraint(equalToConstant: 20),
            self.chartButton.heightAnchor.constraint(equalToConstant: 20),
            
            self.calendarButton.trailingAnchor.constraint(equalTo: self.chartButton.leadingAnchor, constant: -10),
            self.calendarButton.centerYAnchor.constraint(equalTo: self.monthPickerView.centerYAnchor),
            self.calendarButton.widthAnchor.constraint(equalToConstant: 20),
            self.calendarButton.heightAnchor.constraint(equalToConstant: 20),
            
            self.weekView.topAnchor.constraint(equalTo: self.monthPickerView.bottomAnchor, constant: 10),
            self.weekView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.weekView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            self.memoCalendarCollectionView.topAnchor.constraint(equalTo: self.weekView.bottomAnchor),
            self.memoCalendarCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.memoCalendarCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.memoCalendarCollectionViewTopConstraint,
            
            self.memoCalendarBottomSheetView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.memoCalendarBottomSheetView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.memoCalendarBottomSheetView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.memoCalendarBottomSheetViewHeightConstraint,
            
            self.createButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            self.createButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.createButton.widthAnchor.constraint(equalToConstant: 45),
            self.createButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    @objc func openBottomSheet() {
        self.hideMemoCalendarCollectionView()
    }
    
    @objc func onClickChartButton() {
        let CalendarVC = CalendarViewController()
        CalendarVC.modalPresentationStyle = .formSheet
        self.present(CalendarVC, animated: true, completion: nil)
    }
    
    @objc func onClickCreateButton() {
        let writingVC = WritingViewController()
        writingVC.modalPresentationStyle = .formSheet
        self.present(writingVC, animated: true, completion: nil)
    }
}

extension MemoCalendarViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false {
            collectionView.deselectItem(at: indexPath, animated: true)
            self.showMemoCalendarCollectionView()
            for collectionViewcell in collectionView.visibleCells {
                let cell = collectionViewcell as! MemoCalendarCollectionViewCell
                cell.showMemoList()
            }
        } else {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
            self.hideMemoCalendarCollectionView()
            for collectionViewcell in collectionView.visibleCells {
                let cell = collectionViewcell as! MemoCalendarCollectionViewCell
                cell.hideMemoList()
            }
        }
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemoCalendarCollectionViewCell.identifier, for: indexPath) as? MemoCalendarCollectionViewCell else { return UICollectionViewCell()}
        cell.setup()
        cell.update(date: self.dates[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.weekView.frame.width / 7
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
