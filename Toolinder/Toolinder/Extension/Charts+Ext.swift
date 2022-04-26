////
////  Charts+Ext.swift
////  Toolinder
////
////  Created by 송영모 on 2022/04/25.
////
//
//import Foundation
//import Charts
//
//class YAxisValueFormatter: NSObject, IAxisValueFormatter {
//
//    let numFormatter: NumberFormatter
//
//    override init() {
//        numFormatter = NumberFormatter()
//        numFormatter.minimumFractionDigits = 1
//        numFormatter.maximumFractionDigits = 1
//
//        // if number is less than 1 add 0 before decimal
//        numFormatter.minimumIntegerDigits = 1 // how many digits do want before decimal
//        numFormatter.paddingPosition = .beforePrefix
//        numFormatter.paddingCharacter = "0"
//    }
//
//    /// Called when a value from an axis is formatted before being drawn.
//    ///
//    /// For performance reasons, avoid excessive calculations and memory allocations inside this method.
//    ///
//    /// - returns: The customized label that is drawn on the axis.
//    /// - parameter value:           the value that is currently being drawn
//    /// - parameter axis:            the axis that the value belongs to
//    ///
//
//    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        return numFormatter.string(from: NSNumber(floatLiteral: value))!
//    }
//}
