//
//  AuthService.swift
//  breakpoint
//
//  Created by Ali Zuberi  on 2018-11-24.
//  Copyright © 2018 Ali Zuberi . All rights reserved.
//

import Foundation
import Firebase

class AuthSerivce {
    static let instance = AuthSerivce()
    
    func registerUser(withEmail email:String, andPassword password: String, userCreationComplete: @escaping(_ status: Bool, _ error: Error?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                userCreationComplete(false, error)
                return
            }
            let userData = ["provider": user.providerID, "email":user.email]
            DataService.instance.createDBUer(uid: user.uid, userData: userData)
            userCreationComplete(true, nil)
            }
        }
        

 
    func loginUser(withEmail email:String, andPassword password: String, loginComplete: @escaping(_ status: Bool, _ error: Error?) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                loginComplete(false, error)
                return
            } else {
                
            loginComplete(true, nil)
            
            }
            
        }

}
}
