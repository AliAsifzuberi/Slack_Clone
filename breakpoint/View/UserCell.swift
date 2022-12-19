//
//  UserCell.swift
//  breakpoint
//
//  Created by Ali Zuberi  on 2019-02-10.
//  Copyright © 2019 Ali Zuberi . All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var emailLbl: UILabel!
    

    @IBOutlet weak var checkImage: UIImageView!
    
    
    var showing = false
    
    func configureCell(profileImage:UIImage,email: String, isSelected: Bool) {
        self.profileImage.image = profileImage
        self.emailLbl.text = email
        if isSelected {
            self.checkImage.isHidden = false
        } else {
            self.checkImage.isHidden = true
        }
    }
    
    
    

    
    
    // Configure the view for the selected state
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if showing == false {
                checkImage.isHidden = false
                showing = true
            }else{
            checkImage.isHidden = true
                showing = false
                
        }

        
    }

    }
}
