//
//  TestViewController.swift
//  moeum
//
//  Created by 송영모 on 2022/03/23.
//

import UIKit

class TestViewController: UIViewController {
    private lazy var contentView = UIView()
    private lazy var view1 = UIView()
    private lazy var view2 = UIView()
    
    private lazy var testButton = UIButton()
    
    private var view1HeightAnchor: NSLayoutConstraint!
    private var view2HeightAnchor: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    private func configure() {
        self.configureContentView()
        self.configureTestButton()
        self.configureView1()
        self.configureView2()
        self.testColor()
    }
    
    private func testColor() {
        self.contentView.backgroundColor = .red
        self.testButton.backgroundColor = .yellow
        self.view1.backgroundColor = .blue
        self.view2.backgroundColor = .green
    }
    
    private func configureContentView() {
        self.view.addSubview(self.contentView)
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configureView1() {
        self.contentView.addSubview(self.view1)
        
        self.view1.translatesAutoresizingMaskIntoConstraints = false
        self.view1HeightAnchor = self.view1.heightAnchor.constraint(equalToConstant: 100)
        self.view1HeightAnchor.isActive = true
        NSLayoutConstraint.activate([
            self.view1.topAnchor.constraint(equalTo: self.testButton.bottomAnchor),
            self.view1.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.view1.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ])
    }
    
    private func configureView2() {
        self.contentView.addSubview(self.view2)
        
        self.view2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.view2.topAnchor.constraint(equalTo: self.view1.bottomAnchor),
            self.view2.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.view2.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.view2.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
    
    private func configureTestButton() {
        self.contentView.addSubview(self.testButton)
        self.testButton.tintColor = .orange
        self.testButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        self.testButton.addTarget(self, action: #selector(self.didTestButtonTouched(_:)), for: .touchUpInside)
        self.testButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.testButton.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.testButton.widthAnchor.constraint(equalToConstant: 44),
            self.testButton.heightAnchor.constraint(equalToConstant: 44),
//            self.testButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: -5),
            self.testButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
}

extension TestViewController {
    @objc private func didTestButtonTouched(_ sender: UIButton) {
        print("clicked")
        
        self.view1HeightAnchor.constant = 500
        
        UIView.animate(withDuration: 1) {
            print("애니메이션")
            self.contentView.layoutIfNeeded()
        }
    }
}
