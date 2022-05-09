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
//        let tabZero = UINavigationController(rootViewController: NewCalendarViewController())
        let tabZero = NewCalendarViewController()
        let tabZeroBarItem = UITabBarItem(title: "캘린더", image: UIImage(systemName: "calendar"), selectedImage: UIImage(named: "selectedImage.png"))
        
        tabZero.tabBarItem = tabZeroBarItem
//        let tabTwo = UINavigationController(rootViewController: ListViewController())
        let tabTwo = ListViewController()
        let tabTwoBarItem = UITabBarItem(title: "리스트", image: UIImage(systemName: "list.bullet.rectangle.portrait"), selectedImage: UIImage(systemName: "list.bullet.rectangle.portrait"))
        
        tabTwo.tabBarItem = tabTwoBarItem
        
        let tabFour = UINavigationController(rootViewController: AnalysisViewController())
//        let tabFour = AnalysisViewController()
        let tabFourBarItem = UITabBarItem(title: "분석", image: UIImage(systemName: "chart.bar.xaxis"), selectedImage: nil)
        
        tabFour.tabBarItem = tabFourBarItem
        
        self.viewControllers = [tabZero, tabFour]
    }
}


