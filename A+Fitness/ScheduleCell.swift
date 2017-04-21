//
//  ScheduleCell.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-06.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import iMaster
import SnapKit

class ScheduleCell: BaseCollectionVewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let weekdayCellId = "weekdayCellId"
    let scheduleCellId = "scheduleCellId"
    
    var onceOnly = false
    

    let calendar = Calendar.current
    
//    let weekdayNames = ["MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY", "SUNDAY"]
    
    let weekdayCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        var isCellSelected: Bool = false
        return collectionView
    }()
    
    let scheduleView: UIView = {
        let view = UIView()
        view.backgroundColor = myColor.bgBlack
        return view
    }()
    
    let scheduleCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = myColor.lightBlack
        return collectionView
    }()
    
    override func setUpView() {
        backgroundColor = .black
        weekdayCollectionView.delegate = self
        weekdayCollectionView.dataSource = self
        weekdayCollectionView.register(WeekdayCell.self, forCellWithReuseIdentifier: weekdayCellId)
        
        scheduleCollectionView.delegate = self
        scheduleCollectionView.dataSource = self
        scheduleCollectionView.register(ScheduleCollectionCell.self, forCellWithReuseIdentifier: "scheduleCellId")

        
        addCustomView(weekdayCollectionView)
        weekdayCollectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.width.equalToSuperview().offset(-24)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        addCustomView(scheduleView)
        scheduleView.snp.makeConstraints { (make) in
            make.top.equalTo(weekdayCollectionView.snp.bottom)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        scheduleView.addCustomView(scheduleCollectionView)
        scheduleCollectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalToSuperview().offset(8)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = currentDayInThisMonth() - 1
        let indexToScrollTo = IndexPath(item: row, section: 0)
        
        if !onceOnly {
            self.weekdayCollectionView.scrollToItem(at: indexToScrollTo, at: .left, animated: true)
            onceOnly = true
        }
        let currentCell =  weekdayCollectionView.cellForItem(at: indexToScrollTo) as? WeekdayCell
        currentCell?.weekdayLabel.backgroundColor = myColor.lightOrange
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.weekdayCollectionView {
            let numDays = numberOfDaysInThisMonth()
            return numDays
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.weekdayCollectionView {
            var dayNumberCollection:[Int] = []
            let numDays = numberOfDaysInThisMonth()
            for dayNumber in 1...numDays {
                dayNumberCollection.append(dayNumber)
            }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: weekdayCellId, for: indexPath) as! WeekdayCell
            cell.weekdayLabel.text = String(dayNumberCollection[indexPath.item])
            
            if indexPath.item == currentDayInThisMonth() - 1 {
                cell.weekdayLabel.backgroundColor = myColor.orange
                return cell
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: scheduleCellId, for: indexPath) as! ScheduleCollectionCell
            cell.backgroundColor = myColor.textWhite
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.weekdayCollectionView {
            return 0
        } else {
            return 12
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.weekdayCollectionView {
            return CGSize(width: (frame.width - 24) / 5, height: 60)
        }
        else{
           return CGSize(width: frame.width, height: 120)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell =  weekdayCollectionView.cellForItem(at: indexPath) as! WeekdayCell
        
        if indexPath.item == currentDayInThisMonth() - 1 {
            print("Today's Workout.")
            currentCell.isSelected = false
            currentCell.weekdayLabel.backgroundColor = myColor.orange
        } else {
            currentCell.isSelected = true
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let fomerCell =  weekdayCollectionView.cellForItem(at: indexPath) as! WeekdayCell
        
        if indexPath.item == currentDayInThisMonth() - 1 {
            print("Check Other Day's Workout.")
            fomerCell.isSelected = false
            fomerCell.weekdayLabel.backgroundColor = myColor.orange
        }else {
            fomerCell.isSelected = false
        }
    }
  
    private func numberOfDaysInThisMonth() -> Int {
        
        let year = calendar.component(.year, from: Date.init(timeIntervalSinceNow: 0))
        let month = calendar.component(.month, from: Date.init(timeIntervalSinceNow: 0))
        let dateComponents = DateComponents(year: year, month: month)
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count

        return numDays
    }
    
    private func currentDayInThisMonth() -> Int {
        let day = calendar.component(.day, from: Date.init(timeIntervalSinceNow: 0))
        return day
    }
    
}







