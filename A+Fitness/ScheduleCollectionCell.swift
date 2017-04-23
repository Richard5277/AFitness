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

class ScheduleCollectionCell: BaseCollectionVewCell {
    
    let exerciseLaybel: UILabel = {
        let label = UILabel()
        label.text = "Category Name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = myColor.mainBlack
        label.textAlignment = .left
        label.textColor = myColor.textWhite
        return label
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = myColor.mainBlack
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        label.textColor = myColor.textWhite
        return label
    }()
    
    lazy var addButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Add Exercise", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        bt.addTarget(self, action: #selector(handleAddExercise), for: .touchUpInside)
        bt.setTitleColor(myColor.textWhite, for: .normal)
        return bt
    }()

    override func setUpView() {
        addCustomView(exerciseLaybel)
        exerciseLaybel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(120)
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
            make.centerY.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(36)
        }
    }
    
    func handleAddExercise(){
        print("Add Exercise")
    }
    
}





