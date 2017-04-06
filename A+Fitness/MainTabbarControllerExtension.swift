//
//  MainTabbarControllerExtension.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-02.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import Firebase

extension MainTabBarController {
    
    func checkLogIn(){
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }else {
            fetchUser()
        }
    }
    
    func handleLogout(){
        
        do {
            try FIRAuth.auth()?.signOut()
        }catch let logoutError {
            print(logoutError)
        }
        let loginRegisterVC = LoginRegisterViewController()
        loginRegisterVC.delegate = self
        self.present(loginRegisterVC, animated: true, completion: nil)
    }
    
    // Fetch User From Database
    func fetchUser(){
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{ return }
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapShot) in
            if let dictionary = snapShot.value as? [String: AnyObject] {
                let user = User()
                user.setValuesForKeys(dictionary)
                self.user = user
            }
        }, withCancel: nil)
        
    }
    
    func setUpMenu(){
        menuView.addCustomView(logoutButton)
        logoutButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(49)
        }
        menuView.addCustomView(userImageView)
        userImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        menuView.addCustomView(userNameLabel)
        userNameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(80)
            make.left.equalTo(userImageView.snp.right).offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(26)
        }
        menuView.addCustomView(userEmailLabel)
        userEmailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userNameLabel.snp.bottom).offset(6)
            make.left.equalTo(userImageView.snp.right).offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(26)

        }
    }
    
    func handleMenuSlide(){
        
        if isMenuShow {
            menuSlideOut()
        } else if isMenuShow == false {
            menuSlideIn()
        }
        
    }
    
    func menuSlideIn(){
        let menuWidth = windowFrame.width/3*2
        let menuHeight = windowFrame.height
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.clear]
        self.navigationItem.leftBarButtonItem?.title = "Home"
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0.68
            self.menuView.frame = CGRect(x: 0 ,y: 0, width: menuWidth, height: menuHeight)
        }) { (true) in
            self.isMenuShow = true
        }
    }
    
    func menuSlideOut(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: myColor.textWhite]
        let menuWidth = windowFrame.width/3*2
        let menuHeight = windowFrame.height
        self.navigationItem.leftBarButtonItem?.title = "Menu"
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            self.menuView.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: menuHeight)
        }) { (true) in
            self.isMenuShow = false
        }
    }
    
    
    
}

