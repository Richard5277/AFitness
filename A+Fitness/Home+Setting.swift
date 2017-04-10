//
//  Home+Setting.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-07.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit

extension HomeController {
    
    func handleMore(){
        settingsLancher.showSettings()
    }
    
    func showDetailViewForSetting(_ setting: Setting){
        let detailViewController = UIViewController()
        detailViewController.title = setting.name.rawValue
        detailViewController.view.backgroundColor = myColor.bgBlack
        navigationController?.pushViewController(detailViewController, animated: true)
        
        //MARK: Change navigation stack title color
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
}
