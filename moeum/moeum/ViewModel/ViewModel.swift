//
//  ViewModel.swift
//  moeum
//
//  Created by 송영모 on 2022/04/06.
//

import Foundation

protocol ViewModel {
    associatedtype Input
    associatedtype Output

    var input: Input { get }
    var output: Output { get }
}
