//
//  CategoryCell.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-03.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import iMaster
import SnapKit

class CategoryCell: BaseCollectionVewCell {
    
    let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
//        label.backgroundColor = myColor.lightBlack
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = myColor.textWhite
        label.textAlignment = .center
        return label
    }()
    
    override func setUpView() {
        backgroundColor = myColor.bgBlack
        categoryImageView.contentMode = .scaleAspectFill
        categoryImageView.layer.masksToBounds = true
        
        addCustomView(categoryImageView)
        categoryImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        addCustomView(categoryLabel)
        categoryLabel.snp.makeConstraints { (make) in
//            make.right.equalToSuperview()
//            make.bottom.equalToSuperview().offset(16)
//            make.width.equalTo(80)
//            make.height.equalTo(32)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(210)
            make.height.equalTo(42)
        }
    }
}
