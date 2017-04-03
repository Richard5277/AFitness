//
//  iMaster.swift
//  iMaster
//
//  Created by Feihong Zhao on 2017-03-26.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit

public extension UIView {
    func addCustomView(_ view: UIView){
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }
}

public extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}

public extension UIImage {
    func resizeToWidth(_ newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}


public extension String {
    func capitalizingFirstLetter() -> String {
        let firstLetter = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst()) 
        return firstLetter + other
    }
    
    mutating func capitalizeFirstLetter(){
        self = self.capitalizingFirstLetter()
    }
}

