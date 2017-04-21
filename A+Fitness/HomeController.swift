//
//  HomeController.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-06.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import SnapKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let categoriesCellId = "categoriesCellId"
    let scheduleCellId = "scheduleCellId"
    
    let titles = ["Categories", "Schedule"]
    let titleiIcons = [#imageLiteral(resourceName: "categories"), #imageLiteral(resourceName: "schedule")]
    
    var pageIndex: Int = 0
    
    lazy var titleView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 8, height: self.view.frame.height))
        return view
    }()
    
    let arrowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255, a: 0.2)
        view.layer.cornerRadius = 33
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "  Categories"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var titleImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "categories").resizeToWidth(20).withRenderingMode(.alwaysOriginal))
        return imageView
    }()
    
    lazy var menuBar: MenuBar = {
        let menuBar = MenuBar()
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.backgroundColor = .black
        return menuBar
    }()
    
    //MARK: setting menu is no-longer a view, its a object inside the HomController
    //MARK: Importance of 'lazy var'
    lazy var settingsLancher: SettingLauncher = {
        let settingsLauncher = SettingLauncher()
        settingsLauncher.homeController = self
        return settingsLauncher
    }()
    
    let arrowRightImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "arrow_right").resizeToWidth(18).withRenderingMode(.alwaysOriginal))
        return imageView
    }()
    
    let arrowLeftImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "arrow_left").resizeToWidth(18).withRenderingMode(.alwaysOriginal))
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = myColor.bgBlack
        setUpMenuBar()
        setUpNavBarButtons()
        setUpCollectionView()
        setUpArrowView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0{
            let categoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: categoriesCellId, for: indexPath) as! CategoriesCell
            categoriesCell.homeViewController = self
            return categoriesCell
        } else {
            let scheduleCell = collectionView.dequeueReusableCell(withReuseIdentifier: scheduleCellId, for: indexPath) as! ScheduleCell
            return scheduleCell
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let xValue = scrollView.contentOffset.x / 2
        let percentage = xValue / self.view.frame.width
        menuBar.horizontalBarLeftConstraint?.constant = xValue
       
        self.arrowRightImageView.alpha = 1 - percentage * 2
        self.arrowLeftImageView.alpha = percentage * 2
        
        if percentage < 0.25 {
            self.arrowView.backgroundColor = UIColor(r: 250, g: 250, b: 250, a: 0.2 + percentage * 3.2)
        } else {
            self.arrowView.backgroundColor = UIColor(r: 250, g: 250, b: 250, a: 1.8 - percentage * 3.2)
        }
  
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //MARK: change the icon to right target
        let target = Int(targetContentOffset.pointee.x / view.frame.width)
        setTitleForIndex(target)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}

