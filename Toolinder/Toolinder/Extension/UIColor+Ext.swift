//
//  UIColor+Ext.swift
//  moeum
//
//  Created by 송영모 on 2022/04/15.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
    
    class var backgroundLightGray: UIColor { UIColor(hex: 0x272A35) }
    class var backgroundGray: UIColor { UIColor(hex: 0x1F2129) }
    class var neonGreen: UIColor { UIColor(hex: 0x37FFDB) }
    class var blue2: UIColor { UIColor(hex: 0x16E9F6) }
    class var blue3: UIColor { UIColor(hex: 0x0ED3FE) }
    class var blue4: UIColor { UIColor(hex: 0x33A9FF) }
    class var blue5: UIColor { UIColor(hex: 0x3C8AFF) }
    class var blue6: UIColor { UIColor(hex: 0x3153FF) }
    class var blue7: UIColor { UIColor(hex: 0x374FEB) }
    class var line: UIColor { UIColor(hex: 0xE9E9E9) }
    class var gray1: UIColor { UIColor(hex: 0xB9BFD3) }
    class var gray2: UIColor { UIColor(hex: 0xA5ABBF) }
    class var gray3: UIColor { UIColor(hex: 0x969CB1) }
    class var gray4: UIColor { UIColor(hex: 0x888EA3) }
    class var gray5: UIColor { UIColor(hex: 0x797F94) }
    class var gray6: UIColor { UIColor(hex: 0x555B70) }
    class var gray7: UIColor { UIColor(hex: 0x40475C) }
}
