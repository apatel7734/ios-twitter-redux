//
//  TimelineViewController.swift
//  TwitterRedux3
//
//  Created by Ashish Patel on 10/5/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var timelineTableView: UITableView!
    
    var tweets = [Tweet]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
    }
    
    
    override func viewWillAppear(animated: Bool) {
        loadHomeTimelineAndRefreshTable()
    }
    
    
    func loadHomeTimelineAndRefreshTable(){
        TwitterClient.sharedInstance.getHomeTimeLineWithCompletion { (tweets, error) -> () in
            if let tweets = tweets{
                self.tweets = tweets
                self.timelineTableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("customtimelinecell") as CustomTimelineTableViewCell
        
        var tweet = tweets[indexPath.row]
        
        cell.userNameLabel.text = tweet.user?.name?
        cell.screenNameLabel.text = "@\(tweet.user?.screenName?)"
        cell.tweetLabel?.text = tweet.text
        cell.userProfileImageview?.layer.cornerRadius = 8.0
        cell.userProfileImageview?.clipsToBounds = true
        cell.timeLabel.text = tweet.timeAgoDate
        
        cell.replyButton.tag = indexPath.row
        cell.replyButton.addTarget(self, action: "replyButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: "favoriteButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        if let fav = tweet.favorited{
            //            updateButtonState(cell.favoriteButton, favorited: fav)
        }
        
        
        cell.retweetButton.tag = indexPath.row
        cell.retweetButton.addTarget(self, action: "retweetButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        if let userProfile = tweet.user?.profileImageUrl{
            cell.userProfileImageview?.setImageWithURL(NSURL(string: userProfile))
        }
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    func updateTweet(tweet: Tweet) {
        println("updated Tweet Fav = \(tweet.favorited)")
        
    }
    
    
    @IBAction func slideBarButtonClicked(sender: UIBarButtonItem) {
        
        drawerControllerFromAppDelegate()?.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    
    func homeTimelineClicked(){
        
    }
    
    
    func mentionTimelineClicked(){
        
    }
    
    
    func drawerControllerFromAppDelegate() -> MMDrawerController? {
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        return appDelegate.drawerViewController
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
