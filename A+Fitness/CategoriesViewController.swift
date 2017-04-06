//
//  CategoriesViewController.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-02.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import SnapKit
import iMaster
import Firebase

class CategoriesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
//    fileprivate let categoryImages: [UIImage] = [#imageLiteral(resourceName: "chest"), #imageLiteral(resourceName: "streching"), #imageLiteral(resourceName: "cardio"), #imageLiteral(resourceName: "legs"), #imageLiteral(resourceName: "biceps"), #imageLiteral(resourceName: "triceps")]
    fileprivate let categoryImaegNames: [String] = ["CHEST", "STRECHING", "CARDIO", "LEGS", "BICEPS", "TRICEPS"]
    
    private let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Categories"
        collectionView?.backgroundColor = myColor.bgBlack
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.alwaysBounceVertical = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryImaegNames.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        cell.categoryLabel.text = categoryImaegNames[indexPath.item]
        cell.categoryImageView.image = UIImage(named: categoryImaegNames[indexPath.item].lowercased())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 62, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selecte \(categoryImaegNames[indexPath.item])")
        let detailCategoryView = DetailCategoryViewController()
        detailCategoryView.detailCategoryView.coverImage = UIImage(named: categoryImaegNames[indexPath.item].lowercased())
        detailCategoryView.detailCategoryView.labelName = categoryImaegNames[indexPath.item]
        self.navigationController?.pushViewController(detailCategoryView, animated: true)
    }
    
}







