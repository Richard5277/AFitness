//
//  MenuCollectionCell.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-06.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import SnapKit

class MenuCollectionCell: BaseCollectionVewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "categories")
        return imageView
    }()
    
    override func setUpView() {
        super.setUpView()
    }
    
    override var isSelected: Bool {
        didSet{
            imageView.tintColor = isSelected ? .white : UIColor(r: 91, g: 14, b: 13, a: 1)
        }
    }
}
