//
//  LoginRegisterViewController.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-02.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import iMaster
import SnapKit
import Firebase
import FBSDKLoginKit

class LoginRegisterViewController: UIViewController,FBSDKLoginButtonDelegate {
    
    let ref = FIRDatabase.database().reference()
    
    var aFitnessIconHeightAnchorConstrint: NSLayoutConstraint?
    let aFitnessIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = myColor.red
        imageView.layer.cornerRadius = 80
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    var userPortfolioImageViewHeightAnchorConstraint: NSLayoutConstraint?
    lazy var userPortfolioImageView :UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = myColor.orange
        imageView.layer.cornerRadius = 80
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImage)))
        return imageView
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = myColor.textWhite
        return label
    }()
    
    let emailInputField: UITextField = {
        let tf = UITextField()
        tf.textColor = myColor.textWhite
        tf.textAlignment = .natural
        tf.attributedPlaceholder = NSAttributedString(string: "  Email",attributes: [NSForegroundColorAttributeName: myColor.placeHolderWhite, NSFontAttributeName: UIFont.systemFont(ofSize: 14)])
        tf.backgroundColor = UIColor(r: 31, g: 37, b: 37, a: 1)
        tf.layer.cornerRadius = 18
        tf.layer.masksToBounds = true
        return tf
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = myColor.textWhite
        return label
    }()
    
    let passwordInputField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "  Passwrod",attributes: [NSForegroundColorAttributeName: myColor.placeHolderWhite, NSFontAttributeName: UIFont.systemFont(ofSize: 14)])
        tf.isSecureTextEntry = true
        tf.textColor = myColor.textWhite
        tf.backgroundColor = UIColor(r: 31, g: 37, b: 37, a: 1)
        tf.layer.cornerRadius = 18
        tf.layer.masksToBounds = true
        return tf
    }()
    
    var userNameLabelHeightAnchorConstraint: NSLayoutConstraint?
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "User Name"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = myColor.textWhite
        return label
    }()
    
    var userNameInputFieldHeightAnchorConstraint: NSLayoutConstraint?
    let userNameInputField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "  User Name",attributes: [NSForegroundColorAttributeName: myColor.placeHolderWhite, NSFontAttributeName: UIFont.systemFont(ofSize: 14)])
        tf.textColor = myColor.textWhite
        tf.textColor = myColor.textWhite
        tf.backgroundColor = UIColor(r: 31, g: 37, b: 37, a: 1)
        tf.layer.cornerRadius = 18
        tf.layer.masksToBounds = true
        return tf
    }()
    
    
    var loginButtonHeightAnchorConstraint: NSLayoutConstraint?
    lazy var loginButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("LOGIN", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        bt.setTitleColor(myColor.white, for: .normal)
        bt.backgroundColor = myColor.lightOrange
        bt.layer.cornerRadius = 25
        bt.layer.masksToBounds = true
        bt.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return bt
    }()
    
    var registerButtonHeightAnchorConstrinat: NSLayoutConstraint?
    lazy var registerButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("REGISTER", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        bt.setTitleColor(myColor.white, for: .normal)
        bt.backgroundColor = myColor.lightYellow
        bt.layer.cornerRadius = 25
        bt.layer.masksToBounds = true
        bt.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return bt
    }()

    var createAccountButtonHeightAnchorConstraint: NSLayoutConstraint?
    lazy var createAccountButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Create Account", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        bt.setTitleColor(myColor.white, for: .normal)
        bt.addTarget(self, action: #selector(showRegisterPage), for: .touchUpInside)
        return bt
    }()
    
    lazy var facebookButton: UIButton = {
        let button = UIButton(type: .system)
//        button.backgroundColor = myColor.lightYellow
        button.tintColor = .white
        button.setTitle("LOGIN WITH FACEBOOK", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginWithFacebook), for: .touchUpInside)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = myColor.lightBlack
        setUpView()
        self.hideKeyboardWhenTappedAround()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did Log Out of Facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print("Login Error: \(error)")
        }
        print("Successfully Login with Facebook")
        loginFirebaseWithFacebook()
    }

    fileprivate func setUpView(){
        let regularMargin = 16
        let miniMargin = 8

        aFitnessIconHeightAnchorConstrint = aFitnessIcon.heightAnchor.constraint(equalToConstant: 160)
        aFitnessIconHeightAnchorConstrint?.isActive = true
        view.addCustomView(aFitnessIcon)
        aFitnessIcon.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(160)
            make.top.equalToSuperview().offset(36)
        }
        
        userPortfolioImageViewHeightAnchorConstraint = userPortfolioImageView.heightAnchor.constraint(equalToConstant: 0)
        userPortfolioImageViewHeightAnchorConstraint?.isActive = true
        view.addCustomView(userPortfolioImageView)
        userPortfolioImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(160)
            make.top.equalToSuperview().offset(36)
        }
        
        view.addCustomView(emailLabel)
        emailLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(220)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-80)
            make.height.equalTo(36)
        }
        
        view.addCustomView(emailInputField)
        emailInputField.snp.makeConstraints { (make) in
            make.top.equalTo(emailLabel.snp.bottom).offset(miniMargin)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-68)
            make.height.equalTo(36)
        }
        
        view.addCustomView(passwordLabel)
        passwordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(emailInputField.snp.bottom).offset(regularMargin)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-80)
            make.height.equalTo(36)
        }
        
        view.addCustomView(passwordInputField)
        passwordInputField.snp.makeConstraints { (make) in
            make.top.equalTo(passwordLabel.snp.bottom).offset(miniMargin)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-68)
            make.height.equalTo(36)
        }
        
        userNameLabelHeightAnchorConstraint = userNameLabel.heightAnchor.constraint(equalToConstant: 0)
        userNameLabelHeightAnchorConstraint?.isActive = true
        view.addCustomView(userNameLabel)
        userNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(passwordInputField.snp.bottom).offset(regularMargin)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-80)
        }
        
        userNameInputFieldHeightAnchorConstraint = userNameInputField.heightAnchor.constraint(equalToConstant: 0)
        userNameInputFieldHeightAnchorConstraint?.isActive = true
        view.addCustomView(userNameInputField)
        userNameInputField.snp.makeConstraints { (make) in
            make.top.equalTo(userNameLabel.snp.bottom).offset(miniMargin)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-68)
        }
        
        loginButtonHeightAnchorConstraint = loginButton.heightAnchor.constraint(equalToConstant: 50)
        loginButtonHeightAnchorConstraint?.isActive = true
        view.addCustomView(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(userNameInputField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-72)
        }
        
        registerButtonHeightAnchorConstrinat = registerButton.heightAnchor.constraint(equalToConstant: 0)
        registerButtonHeightAnchorConstrinat?.isActive = true
        view.addCustomView(registerButton)
        registerButton.snp.makeConstraints { (make) in
            make.top.equalTo(userNameInputField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-72)
        }
        
        createAccountButtonHeightAnchorConstraint = createAccountButton.heightAnchor.constraint(equalToConstant: 20)
        createAccountButtonHeightAnchorConstraint?.isActive = true
        view.addCustomView(createAccountButton)
        createAccountButton.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(miniMargin)
            make.right.equalToSuperview().offset(-36)
            make.width.equalTo(120)
        }
        
        view.addCustomView(facebookButton)
        facebookButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(36)
        }
    }
    
}

