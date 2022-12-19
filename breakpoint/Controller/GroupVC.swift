//
//  SecondViewController.swift
//  breakpoint
//
//  Created by Ali Zuberi  on 2018-11-24.
//  Copyright © 2018 Ali Zuberi . All rights reserved.
//

import UIKit

class GroupVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var groupTableView: UITableView!
    
    var groupsArray = [Group]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        groupTableView.delegate = self
        groupTableView.dataSource = self
       // groupTableView.reloadData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllGroups { (returnedGroupsArray) in
                self.groupsArray = returnedGroupsArray
                self.groupTableView.reloadData()
        }
        
        }
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = groupTableView.dequeueReusableCell(withIdentifier: "groupCell") as? GroupCell else {return UITableViewCell () }
        let group = groupsArray[indexPath.row]
        cell.configureCell(title: group.groupTitle, description: group.groupDesc , memberCount: group.memberCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVc = storyboard?.instantiateViewController(withIdentifier: "GroupFeedVc") as? GroupFeedVc else {return}
        groupFeedVc.initCroupData(forGroup: groupsArray[indexPath.row])
        
        present(groupFeedVc, animated: true, completion:nil)
        
        
    }


}

