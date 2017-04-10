//
//  HomeController+PieChatView.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-07.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import iMaster
import SnapKit

extension HomeController {

    func setUpArrowView(){
        let viewWidth: CGFloat = self.view.frame.width
        let viewHeight: CGFloat = self.view.frame.height
        self.arrowView.frame = CGRect(x: viewWidth - 33, y: viewHeight - 145, width: 66.0, height: 66.0)
        
        arrowView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changePage)))
        
        arrowView.addCustomView(arrowRightImageView)
        arrowRightImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-14)
            make.centerY.equalToSuperview()
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
        
        arrowView.addCustomView(arrowLeftImageView)
        arrowLeftImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(14)
            make.centerY.equalToSuperview()
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
        
        collectionView?.addSubview(arrowView)
    }
    
    func changePage(){
        if self.pageIndex == 0 {
            goToSchedule()
        } else if self.pageIndex == 1 {
            goToCategories()
        }
    }
    
    func goToSchedule(){
        let indexPathOne = IndexPath(item: 1, section: 0)
        self.collectionView?.selectItem(at: indexPathOne, animated: true, scrollPosition: .right)
        self.setTitleForIndex(1)
    }
    
    func goToCategories(){
        let indexPathZero = IndexPath(item: 0, section: 0)
        self.collectionView?.selectItem(at: indexPathZero, animated: true, scrollPosition: .left)
        self.setTitleForIndex(0)
    }
}
