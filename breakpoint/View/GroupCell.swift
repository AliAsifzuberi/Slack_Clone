//
//  GroupCell.swift
//  breakpoint
//
//  Created by Ali Asif Zuberi on 2019-04-13.
//  Copyright © 2019 Ali Zuberi . All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

   
    @IBOutlet weak var groupMemberLbl: UILabel!
    @IBOutlet weak var groupDescLbl: UILabel!
    @IBOutlet weak var groupTitleLbl: UILabel!
    
    
    func configureCell(title:String, description: String, memberCount: Int) {
        self.groupTitleLbl.text = title
        self.groupDescLbl.text = description
        self.groupMemberLbl.text = "\(memberCount )member"
        
    }
    
    
}
