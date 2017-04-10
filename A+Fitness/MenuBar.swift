//
//  MenuBar.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-06.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import SnapKit

class MenuBar: UIView {

    override init(frame: CGRect){
        super.init(frame: frame)
        setupHorizontalBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var horizontalBarLeftConstraint: NSLayoutConstraint?
    
    func setupHorizontalBar(){
        
        let horizontalBar = UIView()
        horizontalBar.translatesAutoresizingMaskIntoConstraints = false
        horizontalBar.backgroundColor = myColor.textWhite
        horizontalBar.layer.cornerRadius = 2
        horizontalBar.layer.masksToBounds = true
        addSubview(horizontalBar)
        
        horizontalBarLeftConstraint = horizontalBar.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftConstraint?.isActive = true
        
        horizontalBar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBar.heightAnchor.constraint(equalToConstant: 2).isActive = true
        horizontalBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
    }

}
