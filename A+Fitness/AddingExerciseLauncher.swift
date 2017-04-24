//
//  AddExerciseLauncher.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-23.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import iMaster

class AddingExerciseLauncher: NSObject{
    
    var homeController: HomeController?
    let newExercisePageView = UIView()

    
    let cancelButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("CANCEL", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        bt.setTitleColor(myColor.white, for: .normal)
        return bt
    }()
    
    let addButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("ADD", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        bt.setTitleColor(myColor.white, for: .normal)
        return bt
    }()
    
    override init(){
        super.init()
        
//        settingCollectionView.delegate = self
//        settingCollectionView.dataSource = self
//        settingCollectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    
    func handleAddingExercisePageSlideIn(){
        
        if let window = UIApplication.shared.keyWindow {
            
            newExercisePageView.backgroundColor = .purple
            newExercisePageView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: window.frame.height)
            window.addSubview(newExercisePageView)

            cancelButton.frame = CGRect(x: 12, y: 30, width: 80, height: 26)
            cancelButton.addTarget(self, action: #selector(handleAddingExercisePageSlideOut), for: .touchUpInside)
            newExercisePageView.addSubview(cancelButton)
            
            addButton.frame = CGRect(x: window.frame.width - 60, y: 30, width: 36, height: 26)
            addButton.addTarget(self, action: #selector(handleAddingExercise), for: .touchUpInside)
            newExercisePageView.addSubview(addButton)
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.newExercisePageView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
            }, completion: nil)
        }
        
    }
    
    func handleAddingExercisePageSlideOut(){
        if let window = UIApplication.shared.keyWindow {
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.newExercisePageView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: window.frame.height)
            }, completion: nil)
        }
        
    }
    
    func handleAddingExercise(){
        print("Add Exercise Successfully")
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return settings.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
//        cell.setting = settings[indexPath.row]
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height: CGFloat = 80 / CGFloat(settings.count)
//        return CGSize(width: collectionView.frame.width, height: height )
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 8
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let setting = self.settings[indexPath.row]
//        dismissSettings(setting)
//    }
    
}

