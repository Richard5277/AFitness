//
//  DetailCategoryCell.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-03.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import SnapKit
import iMaster

class DetailCategoryCell: BaseCollectionVewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let videoCell = "videoCell"
    
    let subCategoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Single Category Video Title"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = myColor.textWhite
        return label
    }()
    
    lazy var videosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = myColor.bgBlack
        return collectionView
    }()
    
    override func setUpView() {
        self.videosCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: videoCell)

        self.videosCollectionView.dataSource = self
        self.videosCollectionView.delegate = self
        
        self.addCustomView(subCategoryLabel)
        subCategoryLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(8)
            make.width.equalToSuperview()
            make.height.equalTo(24)
        }
        
        self.addCustomView(videosCollectionView)
        videosCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(subCategoryLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: videoCell, for: indexPath)
        cell.backgroundColor = myColor.lightYellow
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Play Video")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width - 48, height: self.frame.height - 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
}






