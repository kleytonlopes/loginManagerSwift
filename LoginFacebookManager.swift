//
//  LoginFacebookManager.swift
//  Collibri
//
//  Created by Kleyton Lopes on 22/09/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginFacebookManager: NSObject {
    //MARK: - Attrubutes
    var student : Student?
    weak var delegate: Loggable!
    var originController : Loggable?
    let loginManager = FBSDKLoginManager()
    var errorLogin: NSError!
    
    //MARK: - Inits
    convenience required init(originController: Loggable) {
        self.init()
        self.originController = originController
    }
    private override init() {
    }
}

//MARK: - Login Protocol
extension LoginFacebookManager: Login {
    func isLogged() -> Bool{
        return FBSDKAccessToken.current() != nil
    }
    
    func signIn(){
        self.student = Student()
        if let viewController = self.originController as? UIViewController {
            loginManager.logIn(withReadPermissions: ["public_profile"], from: viewController) { (result, error) in
                if error == nil {
                    print("Logue meu irmao")
                    self.getFBUserData()
                }else{
                    self.errorLogin = error as NSError!
                }
            }
        
        }
    }
    
    func signOut(){
        loginManager.logOut()
    }
    
    func getFBUserData(){
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields" : "email, name, id, gender"])
            .start(completionHandler:  { (connection, result, error) in
                guard let result = result as? NSDictionary, let email = result["email"] as? String,
                    let user_name = result["name"] as? String,
                    let user_gender = result["gender"] as? String,
                    let user_id_fb = result["id"]  as? String else {
                        return
                }
                
                self.student!.name = user_name
                
                self.delegate?.didSignIn(student: self.student)
                
            })
    }
    
}
