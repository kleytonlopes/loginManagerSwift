//
//  LoginGoogleManager.swift
//  Educational App
//
//  Created by Kleyton Lopes on 11/09/16.
//  Copyright © 2016 App Solutions. All rights reserved.
//

import UIKit

class LoginGoogleManager: NSObject {
    //MARK: - Attrubutes
    var user : Student?
    weak var delegate: Loggable!
    var originController : Loggable?
    
    //MARK: - Inits
    convenience required init(originController: Loggable) {
        self.init()
        self.originController = originController
        configureGIDSign()
    }
    override init() {
    }
    
     //MARK: - GIDSign Configure
    func configureGIDSign(){
        let kClientID = "985781316239-3sm2f5sg08otn3dj4ihm7h8dd06f05rm.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().clientID = kClientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
}

//MARK: - GIDSignIn Delegates
extension LoginGoogleManager : GIDSignInDelegate, GIDSignInUIDelegate{
    //MARK: DidSign
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if(error == nil){
            self.user = Student()
            print("Signed in Successfully")
            
            delegate.didSignIn(student: self.user!)
        }
        else{
            print("\(error.localizedDescription)")
            print("Error in Sign In.")
        }
    }
    
    //MARK: Present from ViewController
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        if let originViewController = self.originController as? UIViewController {
            originViewController.present(viewController, animated: true, completion: nil)
        }
        else{
            print("Is not A View Controller")
        }
        
        
    }
    //MARK: Dismiss from ViewController
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        if let viewController = self.originController as? UIViewController {
            viewController.dismiss(animated: true, completion: nil)
        }
        else{
            print("Is not A View Controller")
        }
    }

}

//MARK: - Login Protocol
extension LoginGoogleManager: Login {
    func isLogged() -> Bool{
        return GIDSignIn.sharedInstance().hasAuthInKeychain()
    }
    
    func signIn(){
        GIDSignIn.sharedInstance().signIn()
        print("Processing Signed In")
    }
    
    func signOut(){
        GIDSignIn.sharedInstance().signOut()
        print("Signed Out Successfully")
    }
}


