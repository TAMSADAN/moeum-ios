//
//  ViewController.swift
//  moeum
//
//  Created by 송영모 on 2022/03/17.
//

import UIKit

class ViewController: UIViewController {
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var titleLabel = UILabel()
    private lazy var previousButton = UIButton()
    private lazy var nextButton = UIButton()
    private lazy var todayButton = UIButton()
    private lazy var weekStackView = UIStackView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.configure()
    }
    
    private func configure() {
        self.configureScrollView()
        self.configureContentView()
        self.configureTitleLabel()
//        self.configurePreviousButton()
        self.configureWeekStackView()
        self.configureWeekLabel()
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
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.backgroundColor = .red
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),

        ])
    }
    
    private func configureTitleLabel() {
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.text = "2022.3"
        self.titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10)
        ])
    }
    
    private func configurePreviousButton() {
        self.contentView.addSubview(self.previousButton)
        self.previousButton.tintColor = .label
        self.previousButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        self.previousButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.previousButton.widthAnchor.constraint(equalToConstant: 44),
            self.previousButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    private func configureWeekStackView() {
        self.contentView.addSubview(self.weekStackView)
        self.weekStackView.distribution = .fillEqually
        self.weekStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.weekStackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            self.weekStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            self.weekStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5)
        ])
    }
    
    private func configureWeekLabel() {
        let days = ["일", "월", "화", "수", "목", "금", "토"]
        
        for day in days {
            let label = UILabel()
            label.text = day
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 12)
            self.weekStackView.addArrangedSubview(label)
            
            if day == "일" {
                label.textColor = .systemRed
            } else if day == "토" {
                label.textColor = .systemBlue
            }
        }
    }
}
