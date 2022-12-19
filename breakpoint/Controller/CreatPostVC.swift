//
//  CreatPostVC.swift
//  breakpoint
//
//  Created by Ali Zuberi  on 2018-12-08.
//  Copyright © 2018 Ali Zuberi . All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CreatPostVC: UIViewController {
    
    
    @IBOutlet weak var sendBTN: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var ProflieImgae: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textView.delegate = self
        sendBTN.bindToKeyboard()
        ProflieImgae.bindToKeyboard()
        textView.bindToKeyboard()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email as! String
    }
    
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
        if textView.text != nil && textView.text != "Say something here.." {
            sendBTN.isEnabled = false
            DataService.instance.uploadPost(withMessage: textView.text, forUID:(Auth.auth().currentUser?.uid)! , WithGroupKey: nil) { (isComplete) in
                if isComplete {
                    self.sendBTN.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.sendBTN.isEnabled = true
                    print("There was an error !")
                }
            }
        }
        
    }
    
}
// fucntion to make text view empty when editing
extension CreatPostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}

