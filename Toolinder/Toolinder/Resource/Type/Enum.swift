//
//  EnumType.swift
//  moeum
//
//  Created by 송영모 on 2022/04/07.
//

import Foundation

enum PageState {
    case defult
    case back
    case next
}

enum RecordType: String {
    case buy = "매수"
    case sell = "매도"
    case memo = "메모"
}
