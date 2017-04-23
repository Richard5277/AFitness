//
//  Home + Login_Extension.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-22.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import Firebase

extension HomeController {
    
    func checkLogIn(){
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }else {
            fetchUser()
        }
    }
    
    func handleLogout(){
        print("Handle Logout")
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

}
