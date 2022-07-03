//
//  Size.swift
//  Toolinder
//
//  Created by 송영모 on 2022/07/03.
//

import UIKit

struct Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    static let mainWidthMargin = 20.0
    static let mainWidth = screenWidth - mainWidthMargin * 2
    static let mainHeight = screenHeight
    
    static let cardWidth = mainWidth
    
    static let cardCalendarHeight = mainHeight * 0.3
    static let cardHeight = mainHeight / 5
    static let cardHeight1 = mainHeight / 6
}
