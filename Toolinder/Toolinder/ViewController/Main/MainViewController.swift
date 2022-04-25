//
//  MainViewController.swift
//  moeum
//
//  Created by 송영모 on 2022/04/04.
//

import UIKit

class MainViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tabOne = CalendarViewController()
        let tabOneBarItem = UITabBarItem(title: "캘린더", image: UIImage(systemName: "calendar"), selectedImage: UIImage(named: "selectedImage.png"))
        
        tabOne.tabBarItem = tabOneBarItem
        
        let tabTwo = UINavigationController(rootViewController: ListViewController()) 
        let tabTwoBarItem = UITabBarItem(title: "리스트", image: UIImage(systemName: "list.bullet.rectangle.portrait"), selectedImage: UIImage(named: "selectedImage2.png"))
        
        tabTwo.tabBarItem = tabTwoBarItem
        
        let tabThree = ChartViewController()
        let tabThreeBarItem = UITabBarItem(title: "통계", image: UIImage(systemName: "chart.pie"), selectedImage: UIImage(named: "selectedImage2.png"))
        
        tabThree.tabBarItem = tabThreeBarItem
        
        self.viewControllers = [tabOne, tabTwo, tabThree]
    }
}


