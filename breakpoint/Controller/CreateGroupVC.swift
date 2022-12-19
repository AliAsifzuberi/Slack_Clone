//
//  CreateGroupVC.swift
//  breakpoint
//
//  Created by Ali Zuberi  on 2019-02-09.
//  Copyright © 2019 Ali Zuberi . All rights reserved.
//

import UIKit
import Firebase

class CreateGroupVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var emailsearchTextField: UITextField!
    
    @IBOutlet weak var groupMemberLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    
    
    var emailArray = [String]()
    var chosenUserArray = [String]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        emailsearchTextField.delegate = self
        emailsearchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        doneBtn.bindToKeyboard()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
    }
    
    @objc func textFieldDidChange() {
        if emailsearchTextField.text == "" {
            emailArray = []
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: emailsearchTextField.text!) { (returnedemailArray) in
                self.emailArray = returnedemailArray
                self.tableView.reloadData()
            }
        }
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else { return UITableViewCell ()}
        
        let profileImage = UIImage(named: "defaultProfileImage")
        
        
        
        cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        if !chosenUserArray.contains(cell.emailLbl.text!) {
            chosenUserArray.append(cell.emailLbl.text!)
            groupMemberLbl.text = chosenUserArray.joined(separator: ", ")
            doneBtn.isHidden = false
        }else {
            chosenUserArray = chosenUserArray.filter({ $0 != cell.emailLbl.text! })
            if chosenUserArray.count >= 1 {
                groupMemberLbl.text = chosenUserArray.joined(separator: ", ")
                

                
            } else {
                groupMemberLbl.text = "Add People"
                doneBtn.isHidden = true
            }
        }
        
    }
    
   
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func DoneBtnWasPressed(_ sender: Any) {
        // creating and pushing the groups to firebase
        if titleTextField.text != "" && descriptionTextField.text != "" {
            DataService.instance.getIds(forUsernames: chosenUserArray) { (idsArray) in
                var userIds = idsArray
                print("ALI:",userIds)
                print("ALIZUBEIR",idsArray)
                userIds.append((Auth.auth().currentUser?.uid)!)
                
                DataService.instance.createGropu(withTitle: self.titleTextField.text!, andDescritpiton: self.descriptionTextField.text!, forUSerIds: userIds, handler: { (groupCreated) in
                    if groupCreated {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print("Sorry ")
                    }
                })
            }
        }
    }
}


extension CreateGroupVC: UITextFieldDelegate {
    
}
