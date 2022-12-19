//
//  LoginVC.swift
//  breakpoint
//
//  Created by Ali Zuberi  on 2018-11-25.
//  Copyright © 2018 Ali Zuberi . All rights reserved.
//

import UIKit

class LoginVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var passwordFwd: UITextField!
    @IBOutlet weak var emailFwd: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailFwd.delegate = self
        passwordFwd.delegate = self

        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func SignInBtnWasPressed(_ sender: Any) {
        if emailFwd.text != nil && passwordFwd.text != nil {
            AuthSerivce.instance.loginUser(withEmail: emailFwd.text!, andPassword: passwordFwd.text!) { (sucess, loginError) in
                if sucess {
                 self.dismiss(animated: true, completion: nil)
                }else{
                    print(String(describing: loginError?.localizedDescription))
                }
                
                AuthSerivce.instance.registerUser(withEmail: self.emailFwd.text!, andPassword: self.passwordFwd.text!, userCreationComplete: { (sucess, registrationError) in
                    if sucess {
                        AuthSerivce.instance.loginUser(withEmail: self.emailFwd.text!, andPassword: self.passwordFwd.text!, loginComplete: { (sucess, nil) in
                            self.dismiss(animated: true, completion: nil)
                            print("Successfly registerd user")
                        })
                    }else{
                        print(String(describing: registrationError?.localizedDescription))
                    }
                })
                
            }
            
        }
    }
    
    
    @IBAction func CloseBtnWasPressd(_ sender: Any) {
        let authVC = storyboard?.instantiateViewController(withIdentifier: "AuthVC")
        present(authVC!, animated: true, completion: nil)
        // or a even better way is
        //dismiss(animated: true, completion: nil)
    }
}


