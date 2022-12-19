//
//  GroupFeedCell.swift
//  breakpoint
//
//  Created by Ali Asif Zuberi on 2019-04-14.
//  Copyright © 2019 Ali Zuberi . All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

   
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    func configureCell(profileImage: UIImage, email: String, content: String) {
        self.profileImage.image = profileImage
        self.emailLbl.text = email
        self.contentLbl.text = content
    }
    
}
