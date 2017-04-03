//
//  Helper.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-02.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import iMaster
import Firebase

let imageCache = NSCache<AnyObject, AnyObject>() // <NSString, UIImage>

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(urlString: String){
        self.image = nil // prevent the flashing of loading image
        
        // check cache for image first
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            
            self.image = cacheImage
            return
        }else {
            // otherwise, download image
            let url = URL(string: urlString)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil{
                    print(error ?? "Image Download Error")
                    return
                }
                DispatchQueue.main.async {
                    
                    if let downloadedImage = UIImage(data: data!){
                        imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                        self.image = downloadedImage
                    }
                }
            }).resume()
        }
        
    }
}

struct myColor {
    static var mainRed: UIColor = UIColor(r: 168, g: 29, b: 32, a: 1)
    static var mainBlack: UIColor = UIColor(r: 0, g: 0, b: 0, a: 1)
    static var textWhite: UIColor = UIColor(r: 255, g: 255, b: 255, a: 1)
    
    static var lightGray: UIColor = UIColor(r: 214, g: 217, b: 224, a: 1)
    static var lightBlack: UIColor = UIColor(r: 25, g: 28, b: 35, a: 0.7)
    static var red: UIColor = UIColor(r: 231, g: 68, b: 40, a: 1)
    static var black: UIColor = UIColor(r: 19, g: 22, b: 31, a: 1)
    static var white: UIColor = UIColor(r: 250, g: 250, b: 250, a: 1)
    static var placeHolderWhite: UIColor = UIColor(r: 255, g: 255, b: 255, a: 0.6)
    static var gray: UIColor = UIColor(r: 179, g: 185, b: 199, a: 1)
    static var yellow: UIColor = UIColor(r: 233, g: 208, b: 56, a: 1)
    static var lightYellow: UIColor = UIColor(r: 233, g: 208, b: 56, a: 0.6)
    static var orange: UIColor = UIColor(r: 240, g: 147, b: 41, a: 1)
    
    // Theme One
    static var lightRed: UIColor = UIColor(r: 253, g: 79, b: 94, a: 1)
    static var lightOrange: UIColor = UIColor(r: 236, g: 90, b: 65, a: 1)
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

class BaseCollectionVewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpView(){
        
    }
}


