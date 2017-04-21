//
//  CategoriesCell.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-06.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import SnapKit

class CategoriesCell: BaseCollectionVewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate {
    
    let cellId = "cellId"
    
    var homeViewController: HomeController?
    
    fileprivate let categoryImaegNames: [String] = ["CHEST", "STRETCHING", "CARDIO", "LEGS", "BICEPS", "TRICEPS"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = myColor.bgBlack
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func setUpView() {
        
        super.setUpView()
        backgroundColor = myColor.bgBlack
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 12, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryImaegNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        cell.categoryLabel.text = categoryImaegNames[indexPath.item]
        cell.categoryImageView.image = UIImage(named: categoryImaegNames[indexPath.item].lowercased())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selecte \(categoryImaegNames[indexPath.item])")
        
        let detailCategoryView = DetailCategoryViewController()
        detailCategoryView.detailCategoryView.coverImage = UIImage(named: categoryImaegNames[indexPath.item].lowercased())
        detailCategoryView.detailCategoryView.labelName = categoryImaegNames[indexPath.item]
        self.homeViewController?.navigationController?.pushViewController(detailCategoryView, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.homeViewController?.arrowView.backgroundColor = UIColor(r: 255, g: 255, b: 255, a: 0.8)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.homeViewController?.arrowView.backgroundColor = UIColor(r: 255, g: 255, b: 255, a: 0.2)
    }
    
}

