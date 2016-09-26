//
//  LoginManager.swift
//  Collibri
//
//  Created by Kleyton Lopes on 25/09/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

enum LoginProvider {
    case Google(originController: Loggable)
    case Facebook(originController: Loggable)
    case Native(user: Student,originController: Loggable)
    
}

class LoginManager: NSObject {
    var login : Login?
    
    override init() {
        
    }
    
    convenience init(_ provider: LoginProvider) {
        self.init()
        setLoginProvider(provider)
    }
    
    func setLoginProvider(_ provider: LoginProvider){
        switch provider {
        case .Google(let originController):
            login = LoginGoogleManager(originController: originController)
            break
        case .Facebook(let originController):
            login = LoginFacebookManager(originController: originController)
            break
        case .Native(let student, let originViewController):
            //login = LoginNativeManager(user: student, originController: originViewController)
            loginWithNative(user: student, originController: originViewController)
            break
        }
    }
    func signIn(){
        login?.delegate = login?.originController
        login?.signIn()
    }
    
    func signOut(){
        login?.signOut()
    }
    
    func logInWith(_ provider: LoginProvider){
        setLoginProvider(provider)
        signIn()
    }
    
    func isLogged() -> Bool{
        if(login == nil){
           return false
        }
        return login!.isLogged()
    }
    
    //TODO: Implementar Login nativo
    private func loginWithNative(user: Student,originController: Loggable){
        //login = LoginNativeManager(originController: originController, user, password)
        //login?.delegate = originController
        //login?.signIn()
    }
    
    
}


