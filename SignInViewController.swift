//
//  SignInGoogleViewController.swift
//  Educational App
//
//  Created by Kleyton Lopes on 08/09/16.
//  Copyright © 2016 App Solutions. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController{
    
    
    @IBOutlet weak var signOutButton: UIButton!

    let loginManager = LoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleAuthUI()
    }
    
    // MARK: - Facebook
    @IBAction func didTapSignInWithFacebook(_ sender: AnyObject) {
        loginManager.logInWith(LoginProvider.Facebook(originController: self))
    }
    
    // MARK: - Google
    @IBAction func didTapSignInWithGoogle(_ sender: AnyObject) {
        loginManager.logInWith(LoginProvider.Google(originController: self))
    }
    
    // MARK: - Native
    @IBAction func didTapSignInWithNative(_ sender: AnyObject) {
        
    }
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        loginManager.signOut()
        toggleAuthUI()
    }

    func toggleAuthUI() {
        if (self.loginManager.isLogged() == true){
            signOutButton.isHidden = false
            
        } else {
            signOutButton.isHidden = true
        }
    
    }
    
}
extension SignInViewController: Loggable{
    internal func didSignIn(student user: Student?) {
        print(user?.name)
        
        toggleAuthUI()
        print("entrou")
    }
}


