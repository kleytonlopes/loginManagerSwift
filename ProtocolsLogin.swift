//
//  ProtocolsLogin.swift
//  Educational App
//
//  Created by Kleyton Lopes on 13/09/16.
//  Copyright © 2016 App Solutions. All rights reserved.
//


protocol Login: class {
    weak var delegate: Loggable! {get set}
    var originController : Loggable? {get}
    init(originController: Loggable)
    func isLogged() -> Bool
    func signIn()
    func signOut()
}

protocol Loggable: class {
    func didSignIn(student: Student?)
}

