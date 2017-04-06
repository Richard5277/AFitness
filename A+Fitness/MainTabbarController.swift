//
//  MainTabbarController.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-02.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import Firebase
import SnapKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate, DidChangeUserDelegate {
   
    let ref = FIRDatabase.database().reference()
    
    var user: User?{
        didSet {
            self.userImageView.loadImageUsingCacheWithUrlString(urlString: (user?.profileImageUrl)!)
            self.userNameLabel.text = user?.name
            self.userEmailLabel.text = user?.email
        }
    }
    
    func didChangeUserWithUid(_ uid: String) {
        print("Did ")
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapShot) in
                if let dictionary = snapShot.value as? [String: AnyObject] {
                    let user = User()
                    user.setValuesForKeys(dictionary)
//                    self.userImageView.image = nil
//                    self.userNameLabel.text = nil
//                    self.userEmailLabel.text = nil
                    self.user = user
                }
            }, withCancel: nil)
    }

    var isMenuShow: Bool = false
    let windowFrame = UIApplication.shared.keyWindow?.bounds ?? UIWindow().bounds
    
    let menuView: UIView = {
        let view = UIView()
        view.backgroundColor = myColor.black
        return view
    }()
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = myColor.textWhite
        label.layer.cornerRadius = 6
        label.textAlignment = .left
        label.layer.masksToBounds = true
        return label
    }()
    
    let userEmailLabel: UILabel = {
        let label = UILabel()
        label.textColor = myColor.textWhite
        label.font = UIFont.systemFont(ofSize: 9)
        label.layer.cornerRadius = 6
        label.textAlignment = .left
        label.layer.masksToBounds = true
        return label
    }()
    
    lazy var logoutButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Logout", for: .normal)
        bt.backgroundColor = myColor.yellow
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        bt.setTitleColor(myColor.mainBlack, for: .normal)
        bt.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return bt
    }()
    
    lazy var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMenuSlide)))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Categories"
        delegate = self
        tabBar.barTintColor = myColor.black
        tabBar.tintColor = myColor.mainRed
        tabBar.unselectedItemTintColor = myColor.white
        
        blackView.alpha = 0
        self.view.addCustomView(blackView)
        blackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        let menuWidth = windowFrame.width/3*2
        let menuHeight = windowFrame.height
        
        self.menuView.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: menuHeight)
        self.view.addSubview(menuView)
        
        let menu = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(handleMenuSlide))
        navigationItem.leftBarButtonItem = menu
        
        setUpTabBar()
        checkLogIn()
        setUpMenu()
        
        for item in tabBar.items! {
            item.setTitleTextAttributes([NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)], for: .normal)
        }
        
    }
    
    fileprivate func setUpTabBar(){
        let categoriesController = CategoriesViewController(collectionViewLayout: UICollectionViewFlowLayout())
        //        let resizedMessageWhite = UIImage().resizeImage(image: UIImage(named: "message-white")!, newWidth: 33)
        //        let resizedMessageRed = UIImage().resizeImage(image: UIImage(named: "message-red")!, newWidth: 33)
        //        let tabOneBarItem = UITabBarItem(title: "Rechat", image: resizedMessageWhite.withRenderingMode(.alwaysOriginal), selectedImage: resizedMessageRed.withRenderingMode(.alwaysOriginal))
        let categoriesBarItem = UITabBarItem(title: "Categories", image: UIImage(), selectedImage: UIImage())
        categoriesController.tabBarItem = categoriesBarItem
        
        let scheduleViewController = ScheduleViewController()
        //        let resizedMomentWhite = UIImage().resizeImage(image: UIImage(named: "moment-white")!, newWidth: 30)
        //        let resizedMomentRed = UIImage().resizeImage(image: UIImage(named: "moment-red")!, newWidth: 30)
        //        let tabThreeItem = UITabBarItem(title: "Moments", image: resizedMomentWhite.withRenderingMode(.alwaysOriginal), selectedImage: resizedMomentRed.withRenderingMode(.alwaysOriginal))
        let scheduleBarItem = UITabBarItem(title: "Calendar", image: UIImage(), selectedImage: UIImage())
        scheduleViewController.tabBarItem = scheduleBarItem
        
        self.viewControllers = [categoriesController, scheduleViewController]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        navigationItem.title = viewController.title
        //        navigationItem.rightBarButtonItem = viewController.navigationItem.rightBarButtonItem
    }
    
}


