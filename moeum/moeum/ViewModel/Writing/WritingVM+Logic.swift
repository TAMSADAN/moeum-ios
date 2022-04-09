//
//  WritingVM+Logic.swift
//  moeum
//
//  Created by 송영모 on 2022/04/08.
//

import Foundation

extension WritingViewModel {
    
    func getDateStringFromDate(date: Date) -> String {
        let weekDays = ["일", "월", "화", "수", "목", "금", "토"]
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .weekday], from: date)
        
        let dateString = String(format: "%d.%02d.%02d (%@)", components.year!, components.month!, components.day!, weekDays[components.weekday! - 1])
        
        return dateString
        
    }
    
    func getTimeStringFromDate(date: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        
        let timeString = String(format: "%02d:%02d", components.hour!, components.minute!)
        
        return timeString
    }
    
    func saveRecord() {
        recordService.postRecord(record: record)
    }
}
