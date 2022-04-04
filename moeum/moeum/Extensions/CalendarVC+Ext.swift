//
//  CalendarVC+UI.swift
//  moeum
//
//  Created by 송영모 on 2022/04/04.
//

import UIKit

extension CalendarViewController {
    func setup() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.headerView)
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
        
        self.view.addSubview(self.weekLabelView)
        self.weekLabelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.weekLabelView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: 10),
            self.weekLabelView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.weekLabelView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        self.view.addSubview(self.calendarView)
        self.calendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.calendarView.topAnchor.constraint(equalTo: self.weekLabelView.bottomAnchor, constant: 5),
            self.calendarView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.calendarView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.calendarView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension CalendarViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false {
            collectionView.deselectItem(at: indexPath, animated: true)
//            self.showMemoCalendarCollectionView()
            for collectionViewcell in collectionView.visibleCells {
                let cell = collectionViewcell as! MemoCalendarCollectionViewCell
                cell.showMemoList()
            }
        } else {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
//            self.hideMemoCalendarCollectionView()
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
//        cell.update(date: self.dates[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calendarView.frame.width / 7
        let height = self.calendarView.frame.height / 5
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
