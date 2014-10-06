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
