//
//  UsersTableViewCell.swift
//  TwitterRedux3
//
//  Created by Ashish Patel on 10/7/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!

    @IBOutlet weak var userScreenNameLabel: UILabel!

    @IBOutlet weak var textDescLabel: UILabel!
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    
    
    @IBAction func replyClicked(sender: UIButton) {
        
    }
    
    
    
    @IBAction func retweetClicked(sender: UIButton) {
        
    }
    
    
    @IBAction func favoriteClicked(sender: UIButton) {
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
