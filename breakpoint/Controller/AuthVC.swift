//
//  AuthVC.swift
//  breakpoint
//
//  Created by Ali Zuberi  on 2018-11-25.
//  Copyright © 2018 Ali Zuberi . All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // check if there is user
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }
    

    
    @IBAction func SignInWithEmailBtnWasPressed(_ sender: Any) {
      //   performSegue(withIdentifier: "EmailSignInVC", sender: nil)
        //or
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
        
    }
    
    
    @IBAction func GoogleBtnWasPressed(_ sender: Any) {
    }
    
    
    @IBAction func FacebookBtnWasPressed(_ sender: Any) {
    }
    
}


