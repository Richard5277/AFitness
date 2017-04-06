//
//  LoginRegiterControllerExtension.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-02.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

extension LoginRegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func handleLogin(){
        guard let email = emailInputField.text, let password = passwordInputField.text else {
            print("Unvalid User")
            return
        }
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil{
                print(error ?? "ERROR")
                return
            }
            if let newUserUid: String = user?.uid {
               print("FIRUser Uid: \(newUserUid)")
                self.delegate?.didChangeUserWithUid(newUserUid)
            }
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    // Need to improve Animation
    func showRegisterPage(){
        UIView.animate(withDuration: 2.6, delay: 0.6, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.aFitnessIconHeightAnchorConstrint?.constant = 0
            self.loginButtonHeightAnchorConstraint?.constant = 0
            self.createAccountButtonHeightAnchorConstraint?.constant = 0
            self.createAccountButton.isHidden = true
        }, completion: {(true) in
            self.userPortfolioImageViewHeightAnchorConstraint?.constant = 160
            self.userNameLabelHeightAnchorConstraint?.constant = 36
            self.userNameInputFieldHeightAnchorConstraint?.constant = 36
            self.registerButtonHeightAnchorConstrinat?.constant = 50
        })
        
    }

    func handleSelectProfileImage(){
        let imagePicker = UIImagePickerController()
        present(imagePicker, animated: true, completion: nil)
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Picker Cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
        }else if let origionalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = origionalImage
        }
        if let selectedImage = selectedImageFromPicker {
            userPortfolioImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func handleRegister(){
        guard let name = userNameInputField.text, let email = emailInputField.text, let password = passwordInputField.text else {
            print("Unvalid User")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
            if error != nil {
                print(error?.localizedDescription ?? "Error")
            }
            
            guard let uid = user?.uid else{
                print("Unvalid User")
                return
            }
            
            // successfully authentiated user
            // store image into firStorage
            let imageName = NSUUID().uuidString
            let storage = FIRStorage.storage().reference().child("profileImages").child("\(imageName).jpg")
            
            // comprestion images, small size, very important, increase speed, save data
            if let profileImage = self.userPortfolioImageView.image , let uploadData = UIImageJPEGRepresentation(profileImage, 0.1){
                storage.put(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil{
                        print(error ?? "Uploading Image to Storage Failed")
                        return
                    }
                    
                    if let profileImageUrl =  metadata?.downloadURL()?.absoluteString{
                        let values = ["name": name, "email": email, "profileImageUrl": profileImageUrl]
                        self.registerUserIntoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                })
            }
        })
    }
 
    func loginWithFacebook(){
        print("Custom Facebook Login Working")
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) {(result, err) in
            if err != nil{
                print("Read User Info Error: \(err)")
                return
            }
            print("Login With Facebook Successfully")
            self.loginFirebaseWithFacebook()
        }
    }
    
    func loginFirebaseWithFacebook(){
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start{(connection, result, err) in
            if err != nil{
                print("Failed to start request: \(err)")
                return
            }
            guard let accessToken = FBSDKAccessToken.current().tokenString else { return }
            let credentials = FIRFacebookAuthProvider.credential(withAccessToken: accessToken)
            FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
                if error != nil{
                    print("Sign In Firebase Error: \(error)")
                    return
                }
                print("Login Success")
                // MARK: Register Facebook User into Firebase User
                self.registerFacebookUserIntoFirebase(user)
                if let newUserUid: String = user?.uid {
                    print("New User Uid: \(newUserUid)")
                    self.delegate?.didChangeUserWithUid(newUserUid)
                }
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    func registerFacebookUserIntoFirebase(_ user: FIRUser?){
        
        guard let email = user?.email, let name = user?.displayName, let uid = user?.uid, let photoUrl = user?.photoURL else {
            print("Unvalid User")
            return
        }
        
        let imageName = NSUUID().uuidString
        let urlString = photoUrl.absoluteString
        
        URLSession.shared.dataTask(with: photoUrl, completionHandler: { (data, response, error) in
            if error != nil{
                print(error ?? "Image Download Error")
                return
            }
            
            DispatchQueue.main.async {
                
                if let downloadedImage = UIImage(data: data!){
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    let storage = FIRStorage.storage().reference().child("profileImages").child("\(imageName).jpg")
                    if let uploadData = UIImageJPEGRepresentation(downloadedImage, 0.1){
                        storage.put(uploadData, metadata: nil, completion: { (metadata, error) in
                            if error != nil{
                                print("Upload Facebook Profile Image to Firebase Storage Failed: \(error)")
                                return
                            }
                            print("Save Facebook Image Into Firebase Success, imageName: \(imageName)")
                            if let profileImageUrl =  metadata?.downloadURL()?.absoluteString{
                                let values = ["name": name, "email": email, "profileImageUrl": profileImageUrl]
                                self.registerUserIntoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                            }
                        })
                    }
                    
                }
            }
        }).resume()
    }
    
    private func registerUserIntoDatabaseWithUID(uid: String, values: [String: AnyObject]){
        let singleRef = self.ref.child("users").child(uid)
        singleRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil{
                print(err ?? "WRONG")
                return
            }else {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
  
}
