//
//  Const.swift
//  moeum
//
//  Created by 송영모 on 2022/04/11.
//

import Foundation
import UIKit

struct Const {
    struct Font {
        static let largeTitle = UIFont.systemFont(ofSize: 34)
        static let title1 = UIFont.systemFont(ofSize: 28)
        static let title2 = UIFont.systemFont(ofSize: 22)
        static let title3 = UIFont.systemFont(ofSize: 20)
        static let headline = UIFont.systemFont(ofSize: 17, weight: .semibold)
        static let callout = UIFont.systemFont(ofSize: 16)
        static let subheadline = UIFont.systemFont(ofSize: 15)
        static let body = UIFont.systemFont(ofSize: 17)
        static let footnote = UIFont.systemFont(ofSize: 13)
        static let caption1 = UIFont.systemFont(ofSize: 12)
        static let caption2 = UIFont.systemFont(ofSize: 11)
        static let caption3 = UIFont.systemFont(ofSize: 10)
        static let caption4 = UIFont.systemFont(ofSize: 9)
        static let caption5 = UIFont.systemFont(ofSize: 8)
        
        static let itemHeadline = UIFont.systemFont(ofSize: 14, weight: .semibold)
        static let itemTitle = UIFont.systemFont(ofSize: 14)
        static let itemBody = UIFont.systemFont(ofSize: 13)
        static let itemFootnote = UIFont.systemFont(ofSize: 11)
    }
    
    struct Color {
        static let white = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        static let red = UIColor(red: 255/255, green: 69/255, blue: 58/255, alpha: 1)
        static let orange = UIColor(red: 255/255, green: 159/255, blue: 10/255, alpha: 1)
        static let yellow = UIColor(red: 255/255, green: 214/255, blue: 10/255, alpha: 1)
        static let green = UIColor(red: 48/255, green: 209/255, blue: 88/255, alpha: 1)
        static let mint = UIColor(red: 102/255, green: 212/255, blue: 207/255, alpha: 1)
        static let teal = UIColor(red: 64/255, green: 200/255, blue: 224/255, alpha: 1)
        static let cyan = UIColor(red: 100/255, green: 210/255, blue: 255/255, alpha: 1)
        static let blue = UIColor(red: 10/255, green: 132/255, blue: 255/255, alpha: 1)
        static let indigo = UIColor(red: 94/255, green: 92/255, blue: 230/255, alpha: 1)
        static let purple = UIColor(red: 191/255, green: 90/255, blue: 242/255, alpha: 1)
        static let pink = UIColor(red: 255/255, green: 55/255, blue: 95/255, alpha: 1)
        static let brown = UIColor(red: 172/255, green: 142/255, blue: 104/255, alpha: 1)
        static let black = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
    }
    
    struct Size {
        static let chartBarMaxHeight = 50.0
        static let chartBarMinHeight = 0.0
        
        static let chartBarWidth = 50.0
    }
}
