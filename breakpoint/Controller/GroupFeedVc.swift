//
//  GroupFeedVc.swift
//  breakpoint
//
//  Created by Ali Asif Zuberi on 2019-04-14.
//  Copyright © 2019 Ali Zuberi . All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVc: UIViewController {
    
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var messageTextFld: UITextField!
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var group: Group?
    var groupMEssages = [Message]()
    
    func initCroupData(forGroup group: Group) {
        self.group = group
    }
    
    override func viewDidLoad() {
        groupTitleLbl.text = group?.groupTitle
        sendBtn.bindToKeyboard()
        messageTextFld.bindToKeyboard()
        super.viewDidLoad()
        
    
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessagesFor(desiredGroup: self.group!, handler: { (returnGroupM) in
                self.groupMEssages = returnGroupM
                self.tableView.reloadData()
            })
        }
        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitleLbl.text = group?.groupTitle
        tableView.dataSource = self
        tableView.dataSource = self
        messageTextFld.bindToKeyboard()
        
    }
    @IBAction func backBtnWasPRessed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
        if messageTextFld.text != nil {
            messageTextFld.isEnabled = false
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: messageTextFld.text!, forUID: Auth.auth().currentUser!.uid, WithGroupKey: group?.Key) { (complete) in
                if complete {
                    self.messageTextFld.text = ""
                    self.messageTextFld.isEnabled = true
                    self.sendBtn.isEnabled = true
                }
            }
        }
    }
    
}
extension GroupFeedVc: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMEssages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell") as?
            GroupFeedCell else {return UITableViewCell ()}
        let message = groupMEssages[indexPath.row]
        DataService.instance.getUsername(forUID: message.senderID) { (email) in
             cell.configureCell(profileImage: UIImage(named: "defaultProfileImage")!, email: email, content: message.content)
        }
       
        
    
    return cell
    }

}

