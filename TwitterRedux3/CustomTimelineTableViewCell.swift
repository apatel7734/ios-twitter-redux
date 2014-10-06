//
//  CustomTimelineTableViewCell.swift
//  TwitterRedux3
//
//  Created by Ashish Patel on 10/5/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import UIKit

class CustomTimelineTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var userProfileImageview: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
