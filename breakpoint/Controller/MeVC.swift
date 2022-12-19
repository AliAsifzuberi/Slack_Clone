//
//  MeVC.swift
//  breakpoint
//
//  Created by Ali Zuberi  on 2018-12-01.
//  Copyright © 2018 Ali Zuberi . All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email as! String
    }
    

   
    @IBAction func signOutPressed(_ sender: Any) {
        
        // creating a popup
        let logoutPopuo = UIAlertController(title: "Logout?", message: "Are you sure you want to logout", preferredStyle: .actionSheet)
        
        let logoutAction = UIAlertAction(title: "logout?", style: .destructive) { (buttonTapped) in
            do {
           try  Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC")
                
                self.present(authVC!, animated: true, completion: nil)
                
            } catch {
                print(error)
                
            }
    }
        // showing the popup
        logoutPopuo.addAction(logoutAction)
    present(logoutPopuo, animated: true, completion: nil)
}
}
