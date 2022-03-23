//
//  ViewController.swift
//  moeum
//
//  Created by 송영모 on 2022/03/17.
//

import UIKit
import Foundation

final class ViewController: UIViewController {
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var titleLabel = UILabel()
    private lazy var dateButton = UIButton()
    private lazy var weekStackView = UIStackView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var calendarMemoView = UIView()
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    private var calendarDate = Date()
    private var days = [String]()
    private var dates = [Date()]
    
    private var collectionViewMaxHeight: CGFloat = 100
    private var collectionViewMinHeight: CGFloat = 0
    private var collectionViewHeight: CGFloat = 100
    private var calendarMemoViewMaxHeight = CGFloat()
    private var calendarMemoViewMinHeight: CGFloat = 0
    private var calendarMemoViewHeight = CGFloat()
    
    
    private var heightAnchor: NSLayoutConstraint!
    private var calendarMemoViewHeightAnchor: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.configure()
    }
    
    override func viewDidLayoutSubviews() {
        self.collectionViewMaxHeight = self.collectionView.frame.height
        self.collectionViewMinHeight = self.collectionViewMaxHeight * 0.3
        self.collectionViewHeight = self.collectionViewMaxHeight
        self.calendarMemoViewMaxHeight = self.collectionViewMaxHeight - self.collectionViewMinHeight
        self.calendarMemoViewMinHeight = 0.0
        self.collectionView.performBatchUpdates(nil)
    }
    
    private func testColor() {
        self.scrollView.backgroundColor = .red
        self.contentView.backgroundColor = .orange
        self.titleLabel.backgroundColor = .yellow
        self.dateButton.backgroundColor = .green
        self.weekStackView.backgroundColor = .blue
        self.collectionView.backgroundColor = .red
        self.calendarMemoView.backgroundColor = .brown
    }
    
    private func configure() {
        self.configureScrollView()
        self.configureContentView()
        self.configureTitleLabel()
        self.configureDateButton()
        self.configureWeekStackView()
        self.configureCollectionView()
        self.configureCalendar()
        self.configureCalendarMemoView()
        self.testColor()
    }
    
    private func configureScrollView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configureContentView() {
        self.scrollView.addSubview(self.contentView)
        //        self.contentView.backgroundColor = .brown
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor),
            self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
        ])
    }
    
    private func configureTitleLabel() {
        self.contentView.addSubview(self.titleLabel)
        //        self.titleLabel.backgroundColor = .systemBlue
        self.titleLabel.text = "2022.3"
        self.titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
        ])
    }
    
    private func configureDateButton() {
        self.contentView.addSubview(self.dateButton)
        self.dateButton.tintColor = .black
        self.dateButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        self.dateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dateButton.widthAnchor.constraint(equalToConstant: 20),
            self.dateButton.heightAnchor.constraint(equalToConstant: 20),
            self.dateButton.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 5),
            self.dateButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
        ])
    }
    
    private func configureWeekStackView() {
        self.contentView.addSubview(self.weekStackView)
        //        self.weekStackView.backgroundColor = .green
        self.weekStackView.distribution = .fillEqually
        self.weekStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.weekStackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 15),
            self.weekStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.weekStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
        
        let days = ["일", "월", "화", "수", "목", "금", "토"]
        
        for day in days {
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
    
    private func configureCollectionView() {
        self.contentView.addSubview(self.collectionView)
        //        self.collectionView.backgroundColor = .red
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor = self.collectionView.heightAnchor.constraint(equalToConstant: self.collectionViewMaxHeight)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.weekStackView.bottomAnchor, constant: 10),
            self.collectionView.leadingAnchor.constraint(equalTo: self.weekStackView.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.weekStackView.trailingAnchor),
        ])
    }
    
    private func configureCalendarMemoView() {
        self.calendarMemoView = CalendarMemoView()
        self.contentView.addSubview(self.calendarMemoView)
        self.calendarMemoView.translatesAutoresizingMaskIntoConstraints = false
        self.calendarMemoViewHeightAnchor = self.calendarMemoView.heightAnchor.constraint(equalToConstant: self.calendarMemoViewMinHeight)
        self.calendarMemoViewHeightAnchor.isActive = true
        
        NSLayoutConstraint.activate([
            self.calendarMemoView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor),
            self.calendarMemoView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.calendarMemoView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.calendarMemoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false {
            collectionView.deselectItem(at: indexPath, animated: true)
            self.collectionViewHeight = self.collectionViewMaxHeight
            self.calendarMemoViewHeight = self.calendarMemoViewMinHeight
            UIView.animate(withDuration: 3, delay: 0, options: [.curveEaseInOut]) {
                self.heightAnchor.constant = self.collectionViewHeight
                self.heightAnchor.isActive = true
//                self.calendarMemoViewHeightAnchor.constant = self.calendarMemoViewHeight
//                self.calendarMemoViewHeightAnchor.isActive = true
                self.collectionView.performBatchUpdates(nil)
                self.calendarMemoView.layoutIfNeeded()
            }
        } else {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
            self.collectionViewHeight = self.collectionViewMinHeight
            self.calendarMemoViewHeight = self.calendarMemoViewMaxHeight
            UIView.animate(withDuration: 3, delay: 0, options: [.curveLinear]) {
                self.heightAnchor.constant = self.collectionViewHeight
                self.heightAnchor.isActive = true
//                self.calendarMemoViewHeightAnchor.constant = self.calendarMemoViewHeight
//                self.calendarMemoViewHeightAnchor.isActive = true
                self.collectionView.performBatchUpdates(nil)
                self.calendarMemoView.layoutIfNeeded()
            }
        }
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell()}
        cell.update(date: self.dates[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.weekStackView.frame.width / 7
        let height = self.collectionViewHeight / 5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
}

extension ViewController {
    
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
        self.titleLabel.text = date
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
        self.collectionView.reloadData()
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

//final class ViewController: UIViewController {
//
//    private lazy var scrollView = UIScrollView()
//    private lazy var contentView = UIView()
//    private lazy var titleLabel = UILabel()
//    private lazy var previousButton = UIButton()
//    private lazy var nextButton = UIButton()
//    private lazy var todayButton = UIButton()
//    private lazy var weekStackView = UIStackView()
//    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//
//    private let calendar = Calendar.current
//    private let dateFormatter = DateFormatter()
//    private var calendarDate = Date()
//    private var days = [String]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = .systemBackground
//        self.configure()
//    }
//
//    private func configure() {
//        self.configureScrollView()
//        self.configureContentView()
//        self.configureTitleLabel()
//        self.configurePreviousButton()
//        self.configureNextButton()
//        self.configureTodayButton()
//        self.configureWeekStackView()
//        self.configureWeekLabel()
//        self.configureCollectionView()
//        self.configureCalendar()
//    }
//
//    private func configureScrollView() {
//        self.view.addSubview(self.scrollView)
//        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
//            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
//            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
//            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
//        ])
//    }
//
//    private func configureContentView() {
//        self.scrollView.addSubview(self.contentView)
//        self.contentView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
//            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
//            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
//            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
//            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
//        ])
//    }
//
//    private func configureTitleLabel() {
//        self.contentView.addSubview(self.titleLabel)
//        self.titleLabel.text = "2000년 01월"
//        self.titleLabel.font = .monospacedSystemFont(ofSize: 18, weight: .bold)
//        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
//            self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
//        ])
//    }
//
//    private func configurePreviousButton() {
//        self.contentView.addSubview(self.previousButton)
//        self.previousButton.tintColor = .label
//        self.previousButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
//        self.previousButton.addTarget(self, action: #selector(self.didPreviousButtonTouched), for: .touchUpInside)
//        self.previousButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.previousButton.widthAnchor.constraint(equalToConstant: 44),
//            self.previousButton.heightAnchor.constraint(equalToConstant: 44),
//            self.previousButton.trailingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor, constant: -5),
//            self.previousButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor)
//        ])
//    }
//
//    private func configureNextButton() {
//        self.contentView.addSubview(self.nextButton)
//        self.nextButton.tintColor = .label
//        self.nextButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
//        self.nextButton.addTarget(self, action: #selector(self.didNextButtonTouched), for: .touchUpInside)
//        self.nextButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.nextButton.widthAnchor.constraint(equalToConstant: 44),
//            self.nextButton.heightAnchor.constraint(equalToConstant: 44),
//            self.nextButton.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 5),
//            self.nextButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor)
//        ])
//    }
//
//    private func configureTodayButton() {
//        self.contentView.addSubview(self.todayButton)
//        self.todayButton.setTitle("Today", for: .normal)
//        self.todayButton.setTitleColor(.systemBackground, for: .normal)
//        self.todayButton.backgroundColor = .label
//        self.todayButton.layer.cornerRadius = 5
//        self.todayButton.addTarget(self, action: #selector(self.didTodayButtonTouched), for: .touchUpInside)
//        self.todayButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.todayButton.widthAnchor.constraint(equalToConstant: 60),
//            self.todayButton.heightAnchor.constraint(equalToConstant: 30),
//            self.todayButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
//            self.todayButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor)
//        ])
//    }
//
//    private func configureWeekStackView() {
//        self.contentView.addSubview(self.weekStackView)
//        self.weekStackView.distribution = .fillEqually
//        self.weekStackView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.weekStackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 40),
//            self.weekStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
//            self.weekStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5)
//        ])
//    }
//
//    private func configureWeekLabel() {
//        let dayOfTheWeek = ["일", "월", "화", "수", "목", "금", "토"]
//
//        for i in 0..<7 {
//            let label = UILabel()
//            label.text = dayOfTheWeek[i]
//            label.textAlignment = .center
//            self.weekStackView.addArrangedSubview(label)
//        }
//    }
//
//    private func configureCollectionView() {
//        self.contentView.addSubview(self.collectionView)
//        self.collectionView.dataSource = self
//        self.collectionView.delegate = self
//        self.collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
//        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.collectionView.topAnchor.constraint(equalTo: self.weekStackView.bottomAnchor, constant: 10),
//            self.collectionView.leadingAnchor.constraint(equalTo: self.weekStackView.leadingAnchor),
//            self.collectionView.trailingAnchor.constraint(equalTo: self.weekStackView.trailingAnchor),
//            self.collectionView.heightAnchor.constraint(equalToConstant: <#T##CGFloat#>: self.contentView.heightAnchor),
//            self.collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
//        ])
//    }
//
//}
//
//extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.days.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell() }
//        cell.update(day: self.days[indexPath.item])
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = self.weekStackView.frame.width / 7
//        return CGSize(width: width, height: width * 1.3)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return .zero
//    }
//
//}
//
//extension ViewController {
//
//    private func configureCalendar() {
//        self.dateFormatter.dateFormat = "yyyy년 MM월"
//        self.today()
//    }
//
//    private func startDayOfTheWeek() -> Int {
//        return self.calendar.component(.weekday, from: self.calendarDate) - 1
//    }
//
//    private func endDate() -> Int {
//        return self.calendar.range(of: .day, in: .month, for: self.calendarDate)?.count ?? Int()
//    }
//
//    private func updateCalendar() {
//        self.updateTitle()
//        self.updateDays()
//    }
//
//    private func updateTitle() {
//        let date = self.dateFormatter.string(from: self.calendarDate)
//        self.titleLabel.text = date
//    }
//
//    private func updateDays() {
//        self.days.removeAll()
//        let startDayOfTheWeek = self.startDayOfTheWeek()
//        let totalDays = startDayOfTheWeek + self.endDate()
//
//        for day in Int()..<totalDays {
//            if day < startDayOfTheWeek {
//                self.days.append(String())
//                continue
//            }
//            self.days.append("\(day - startDayOfTheWeek + 1)")
//        }
//
//        self.collectionView.reloadData()
//    }
//
//    private func minusMonth() {
//        self.calendarDate = self.calendar.date(byAdding: DateComponents(month: -1), to: self.calendarDate) ?? Date()
//        self.updateCalendar()
//    }
//
//    private func plusMonth() {
//        self.calendarDate = self.calendar.date(byAdding: DateComponents(month: 1), to: self.calendarDate) ?? Date()
//        self.updateCalendar()
//    }
//
//    private func today() {
//        let components = self.calendar.dateComponents([.year, .month], from: Date())
//        self.calendarDate = self.calendar.date(from: components) ?? Date()
//        self.updateCalendar()
//    }
//
//}
//
//extension ViewController {
//    @objc private func didPreviousButtonTouched(_ sender: UIButton) {
//        self.minusMonth()
//    }
//
//    @objc private func didNextButtonTouched(_ sender: UIButton) {
//        self.plusMonth()
//    }
//
//
//    @objc private func didTodayButtonTouched(_ sender: UIButton) {
//        self.today()
//    }
//
//}
