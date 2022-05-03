//
//  MainViewController.swift
//  moeum
//
//  Created by 송영모 on 2022/04/04.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        let tabZero = NewCalendarViewController()
        let tabZeroBarItem = UITabBarItem(title: "뉴 캘린더", image: UIImage(systemName: "calendar"), selectedImage: UIImage(named: "selectedImage.png"))
        
        tabZero.tabBarItem = tabZeroBarItem
        
        
        let tabOne = CalendarViewController()
        let tabOneBarItem = UITabBarItem(title: "캘린더", image: UIImage(systemName: "calendar"), selectedImage: UIImage(named: "selectedImage.png"))
        
        tabOne.tabBarItem = tabOneBarItem
        
        let tabTwo = UINavigationController(rootViewController: ListViewController()) 
        let tabTwoBarItem = UITabBarItem(title: "리스트", image: UIImage(systemName: "list.bullet.rectangle.portrait"), selectedImage: UIImage(named: "selectedImage2.png"))
        
        tabTwo.tabBarItem = tabTwoBarItem
//
//        let tabThree = ChartViewController()
//        let tabThreeBarItem = UITabBarItem(title: "통계", image: UIImage(systemName: "chart.pie"), selectedImage: UIImage(named: "selectedImage2.png"))
//
//        tabThree.tabBarItem = tabThreeBarItem
        
        let tabFour = UINavigationController(rootViewController: AnalysisViewController())
        let tabFourBarItem = UITabBarItem(title: "분석", image: UIImage(systemName: "chart.bar.xaxis"), selectedImage: nil)
        
        tabFour.tabBarItem = tabFourBarItem
        
        self.viewControllers = [tabZero, tabOne, tabTwo, tabFour]
    }
}


