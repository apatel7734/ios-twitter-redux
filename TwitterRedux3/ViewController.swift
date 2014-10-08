//
//  ViewController.swift
//  TwitterRedux3
//
//  Created by Ashish Patel on 10/5/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backgroundProfileImage: UIImageView!
    @IBOutlet weak var userProfileImageView: UIImageView!
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var tweetsCounterLabel: UILabel!
    @IBOutlet weak var followersCounterLabel: UILabel!
    @IBOutlet weak var followingCounterLabel: UILabel!
    
    
    @IBOutlet weak var userTableView: UITableView!
    
    var retweets = [Tweet]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        headerView.layer.borderColor = UIColor.lightGrayColor().CGColor
        headerView.layer.borderWidth = 1
        headerView.clipsToBounds = true
        
        userTableView.delegate = self
        userTableView.dataSource = self
        
        userTableView.rowHeight = UITableViewAutomaticDimension
        
        if let backUrl = User.currentUser?.backgroundImageUrl{
            backgroundProfileImage.setImageWithURL(NSURL(string: backUrl))
        }
        
        if let userUrl = User.currentUser?.profileImageUrl{
            userProfileImageView.setImageWithURL(NSURL(string: userUrl))
        }
        
        companyNameLabel.text = User.currentUser?.tagLine
        if let number = User.currentUser?.followersCount{
            tweetsCounterLabel.text = "32"
            followersCounterLabel.text = "364"
            followingCounterLabel.text = "3000"
        }
        if let screenName = User.currentUser?.screenName{
            screenNameLabel.text = "@\(screenName)"
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        loadRetweetsOfmeAndRefreshTable()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cell = tableView.dequeueReusableCellWithIdentifier("userstableviewcell") as UsersTableViewCell
        
        var tweet = retweets[indexPath.row]
        
        cell.userNameLabel.text = tweet.user?.name
        cell.userScreenNameLabel.text = tweet.user?.screenName
        if let url = tweet.user?.profileImageUrl{
            cell.userProfileImageView.setImageWithURL(NSURL(string: url))
        }
        
        cell.textDescLabel.text = tweet.text
        cell.dateTimeLabel.text = tweet.timeAgoDate
        
        
        
        return cell
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(retweets.count >= 3){
            return 3
        }else if( retweets.count < 3){
            return retweets.count
        }else{
            return 0
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slideMenuBarButtonClicked(sender: UIBarButtonItem) {
        drawerControllerFromAppDelegate()?.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    
    
    func drawerControllerFromAppDelegate() -> MMDrawerController? {
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        return appDelegate.drawerViewController
    }
    
    
    
    func loadRetweetsOfmeAndRefreshTable(){
        TwitterClient.sharedInstance.getRetweetsOfMeWithCompletion{ (tweets, error) -> () in
            if let tweets = tweets{
                self.retweets = tweets
                self.userTableView.reloadData()
            }
        }
    }
    
    
    
}

