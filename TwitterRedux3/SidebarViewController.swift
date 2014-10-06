//
//  SidebarViewController.swift
//  TwitterRedux3
//
//  Created by Ashish Patel on 10/5/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import UIKit

class SidebarViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var sidebarTableView: UITableView!
    
    var timelines: [String] = ["reserved for header","Home Timeline", "Mentions Timeline"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        sidebarTableView.delegate = self
        sidebarTableView.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0){
            var headerCell =  tableView.dequeueReusableCellWithIdentifier("headercell") as HeaderTableViewCell
            // set user image, username and companyname here
            
            headerCell.userNameLabel.text = User.currentUser?.name!
            headerCell.companyNameLabel.text = User.currentUser?.tagLine!
            if let url = User.currentUser?.profileImageUrl{
                headerCell.profileImageView.setImageWithURL(NSURL(string: url))
            }
            
            
            return headerCell
            
        }else{
            var timelineCell =  tableView.dequeueReusableCellWithIdentifier("timelinecell") as TimelineTableViewCell
            timelineCell.timelineLabel.text = timelines[indexPath.row]
            return timelineCell
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        if(indexPath.row == 0){
            println("Profile Clicked")
            var profileViewController = appDelegate.viewControllers[0]
            drawerControllerFromAppDelegate()?.setCenterViewController(profileViewController, withCloseAnimation: true, completion: nil)
            
        }else if ( indexPath.row == 1){
            println("Home Timeline Clicked")
            var homeTimelineController = appDelegate.viewControllers[1]
            drawerControllerFromAppDelegate()?.setCenterViewController(homeTimelineController, withCloseAnimation: true, completion: nil)
            
        }else if(indexPath.row == 2){
            println("Mentions Clicked")
            var mentionTimelineController = appDelegate.viewControllers[1]
            drawerControllerFromAppDelegate()?.setCenterViewController(mentionTimelineController, withCloseAnimation: true, completion: nil)
        }
        
    }
    
    
    func drawerControllerFromAppDelegate() -> MMDrawerController? {
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        return appDelegate.drawerViewController
    }
}
