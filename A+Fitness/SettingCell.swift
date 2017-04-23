//
//  SettingCell.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-06.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import SnapKit

class SettingCell: BaseCollectionVewCell {
    
    var setting: Setting? {
        didSet{
            
            if let imageName = setting?.iconName, let labelName = setting?.name {
                settingIcon.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                settingIcon.tintColor = .darkGray
                settingLabel.text = labelName.rawValue
            }
            
        }
    }
    
    let settingIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let settingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    let seperator: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override func setUpView() {
        super.setUpView()
        backgroundColor = UIColor(r: 253, g: 253, b: 253, a: 0.85)
        
        addSubview(settingIcon)
        settingIcon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        addSubview(settingLabel)
        settingLabel.snp.makeConstraints { (make) in
            make.left.equalTo(settingIcon.snp.right).offset(32)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-8)
            make.height.equalToSuperview()
        }
        
        addSubview(seperator)
        seperator.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(0.6)
            make.width.equalToSuperview()
        }
    }
    
    override var isHighlighted: Bool {
        didSet{
            backgroundColor = isHighlighted ? .darkGray : .white
            settingLabel.textColor = isHighlighted ? .white : .black
            settingIcon.tintColor = isHighlighted ? .white : .darkGray
        }
    }
}


