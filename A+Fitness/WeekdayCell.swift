//
//  WeekdayCell.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-10.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import iMaster
import SnapKit

class WeekdayCell: BaseCollectionVewCell {
    
    lazy var weekdayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.backgroundColor = .clear
        label.textColor = myColor.textWhite
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = myColor.textWhite
        return view
    }()
    
    override func setUpView() {
        addCustomView(weekdayLabel)
        weekdayLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        addCustomView(separatorView)
        separatorView.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.height.equalToSuperview().offset(-41)
            make.width.equalTo(1)
            make.centerY.equalToSuperview()
        }
    }
    
    override var isSelected: Bool {
        
        didSet {
            self.weekdayLabel.backgroundColor = isSelected ? myColor.yellow : UIColor.black
            self.weekdayLabel.textColor = isSelected ? myColor.black : myColor.textWhite
        }
        
    }


}
