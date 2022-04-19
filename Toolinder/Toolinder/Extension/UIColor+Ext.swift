//
//  UIColor+Ext.swift
//  moeum
//
//  Created by 송영모 on 2022/04/15.
//

import Foundation
import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
