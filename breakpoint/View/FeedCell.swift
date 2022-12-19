//
//  FeedCell.swift
//  breakpoint
//
//  Created by Ali Zuberi  on 2018-12-25.
//  Copyright © 2018 Ali Zuberi . All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

   
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    func configureCell(profileImage:UIImage, email:String, content:String){
        self.profileImage.image = profileImage
        self.emailLbl.text = email
        self.contentLbl.text = content
    }
    
}
