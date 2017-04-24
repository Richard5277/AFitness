//
//  ScheduleCollectionCell.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-20.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import SnapKit
import iMaster

class ScheduleCollectionCell: BaseCollectionVewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let scheduleCellID = "scheduleCellID"
    lazy var specialID: Int = 0
    
    var homeViewController: HomeController?
    
    lazy var addingExerciseLauncher: AddingExerciseLauncher = {
        let addingExerciseLauncher = AddingExerciseLauncher()
        addingExerciseLauncher.homeController = self.homeViewController
        return addingExerciseLauncher
    }()
    
    var numberOfExercise: Int = 0
    
    let exerciseLaybel: UILabel = {
        let label = UILabel()
        label.text = "Working Out Schedule"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = myColor.mainBlack
        label.textAlignment = .center
        return label
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = myColor.mainBlack
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        label.textColor = myColor.mainBlack
        return label
    }()
    
    lazy var addButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Add Exercise", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        bt.backgroundColor = myColor.orange
        bt.addTarget(self, action: #selector(handleNew), for: .touchUpInside)
        bt.setTitleColor(myColor.mainBlack, for: .normal)
        bt.layer.cornerRadius = 12
        bt.layer.masksToBounds = true
        return bt
    }()
    
    let scheduleCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = myColor.lightGray
        return collectionView
    }()

    override func setUpView() {
        
        scheduleCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: scheduleCellID)
        scheduleCollectionView.delegate = self
        scheduleCollectionView.dataSource = self
        
        addCustomView(exerciseLaybel)
        exerciseLaybel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        
        addCustomView(dayLabel)
        dayLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        addCustomView(addButton)
        addButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
            make.width.equalToSuperview()
            make.height.equalTo(32)
        }
        
        addCustomView(scheduleCollectionView)
        scheduleCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(addButton.snp.bottom).offset(8)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    func handleAddExercise(){
//        print("Add Exercise to Day: \(self.specialID)")
//        self.numberOfExercise += 1
//        self.scheduleCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfExercise
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: scheduleCellID, for: indexPath)
        cell.backgroundColor = .purple
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func handleNew(){
        addingExerciseLauncher.handleAddingExercisePageSlideIn()
    }
    
}


