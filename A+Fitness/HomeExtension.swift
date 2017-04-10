//
//  HomeExtension.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-07.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit

extension HomeController {
    
    func setUpCollectionView(){
        //MARK: Change collectionView scroll direction to horizontal
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            //MARK: Reduce the gap between different cells
            flowLayout.minimumLineSpacing = 0
        }
        
        //setup title view
        setUpTitleView()
        
        navigationController?.navigationBar.tintColor = myColor.white
        collectionView?.backgroundColor = myColor.bgBlack
        navigationController?.navigationBar.isTranslucent = false
        
        
        //Seperate Different Cells to pages as a whole
        collectionView?.isPagingEnabled = true
        
        collectionView?.register(CategoriesCell.self, forCellWithReuseIdentifier: categoriesCellId)
        collectionView?.register(ScheduleCell.self, forCellWithReuseIdentifier: scheduleCellId)
    }
    
    func setUpTitleView(){
        titleView.addCustomView(titleImageView)
        titleImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        titleView.addCustomView(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleImageView.snp.right)
            make.right.equalToSuperview()
            make.height.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        navigationItem.titleView = titleView
    }
    
    func setUpMenuBar(){
        
        view.addSubview(menuBar)
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        menuBar.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(2)
        }
        
    }
    
    func setUpNavBarButtons(){
        let searchImage = UIImage(named: "search")?.resizeToWidth(28).withRenderingMode(.alwaysTemplate)
        let searchButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "more")?.resizeToWidth(28).withRenderingMode(.alwaysTemplate)
        let moreButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButtonItem,searchButtonItem]
    }
    
    func handleSearch(){
        print("Search")
    }
    
    func setTitleForIndex(_ index: Int){
        self.titleLabel.text = "  \(titles[index])"
        self.titleImageView.image = titleiIcons[index]
        self.pageIndex = index
    }
    
    func scrollToMenuAtIndex(_ menuIndex: Int){
        let indexPath = NSIndexPath(item: menuIndex, section: 0) as IndexPath
        collectionView?.scrollToItem(at: indexPath, at: .init(rawValue: 0) , animated: true)
        setTitleForIndex(menuIndex)
    }
    

    
    
}
