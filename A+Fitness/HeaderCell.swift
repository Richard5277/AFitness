//
//  HeaderCell.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-03.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
class HeaderCell: BaseCollectionVewCell {
    
    let screenWidth = UIScreen.main.bounds.width
    
    let coverImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.backgroundColor = myColor.red
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        return imageview
    }()
    let label: UILabel = {
        let label = UILabel()
        label.text = "RICH"
        label.textColor = myColor.white
        label.textAlignment = .center
        label.layer.cornerRadius = 50
        label.layer.masksToBounds = true
        label.backgroundColor = myColor.lightBlack
        return label
    }()
    
    override func setUpView() {
        addCustomView(coverImageView)
        coverImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(self.frame.width)
            make.bottom.equalToSuperview().offset(-32)
        }
        addCustomView(label)
        label.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
    }
}
