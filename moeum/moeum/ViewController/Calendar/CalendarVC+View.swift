//
//  CalendarVC+UI.swift
//  moeum
//
//  Created by 송영모 on 2022/04/04.
//

import UIKit
import RxSwift
import RxCocoa

extension CalendarViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = calendarView.frame.width / 7
        let height = calendarView.frame.height / 5
            return CGSize(width: width, height: height)
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return .zero
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return .zero
        }
    
    
//        func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//            print("click")
//            if collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false {
//                collectionView.deselectItem(at: indexPath, animated: true)
//                print("hide bottom sheet")
//                showCalendarView()
//                
//                for collectionViewcell in collectionView.visibleCells {
//                    let cell = collectionViewcell as! CalendarViewCell
//    //                cell.showMemoList()
//                }
//            } else {
//                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
//                print("show bottom sheet")
//                let cell = collectionView.cellForItem(at: indexPath) as! CalendarViewCell
//                print(cell.date)
//                hideCalendarView()
//                for collectionViewcell in collectionView.visibleCells {
//                    let cell = collectionViewcell as! CalendarViewCell
//    //                cell.hideMemoList()
//                }
//            }
//            return false
//        }
    
    func setView() {
        view.addSubview(weekLabelView)
        view.addSubview(calendarView)
        view.addSubview(headerView)
        view.addSubview(bottomSheet)
        view.addSubview(writingButton)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        weekLabelView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        writingButton.translatesAutoresizingMaskIntoConstraints = false
        bottomSheet.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
//        calendarView.backgroundColor = .green
//        bottomSheet.backgroundColor = .blue
//        headerView.backgroundColor = .brown
        bottomSheet.alpha = 0
        calendarViewBottomConstraint =  calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 20),
            
            weekLabelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            weekLabelView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            weekLabelView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            calendarView.topAnchor.constraint(equalTo: weekLabelView.bottomAnchor, constant: 5),
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calendarViewBottomConstraint,
            
            bottomSheet.topAnchor.constraint(equalTo: calendarView.bottomAnchor),
            bottomSheet.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomSheet.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomSheet.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            writingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            writingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
}

extension CalendarViewController {
    func showDatePicker() {
        
    }
    
    func hideDatePicker() {
        
    }
    
    func showCalendarView() {
        calendarViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.25, animations: {
            self.calendarViewBottomConstraint.isActive = true
            self.bottomSheet.alpha = 0
            self.view.layoutIfNeeded()
            
            self.calendarView.performBatchUpdates(nil)
        })
        
        for CalendarViewCell in calendarView.visibleCells {
            let cell = CalendarViewCell as! CalendarViewCell
            cell.show()
        }
    }
    
    func hideCalendarView() {
        calendarViewBottomConstraint.constant = -500
        UIView.animate(withDuration: 0.25, animations: {
            self.calendarViewBottomConstraint.isActive = true
            self.bottomSheet.alpha = 1
            self.view.layoutIfNeeded()
            self.calendarView.performBatchUpdates(nil)
            
        })
        
        for CalendarViewCell in calendarView.visibleCells {
            let cell = CalendarViewCell as! CalendarViewCell
            cell.hide()
        }
    }
    
    func showHighlightCell(indexPath: IndexPath) {
        for CalendarViewCell in calendarView.visibleCells {
            let cell = CalendarViewCell as! CalendarViewCell
            cell.hideHighlight()
        }
        
        let cell = calendarView.cellForItem(at: indexPath) as! CalendarViewCell
        cell.showHighlight()
    }
}
