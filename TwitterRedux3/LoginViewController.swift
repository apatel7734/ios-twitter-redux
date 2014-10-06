//
//  LoginViewController.swift
//  TwitterRedux3
//
//  Created by Ashish Patel on 10/5/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var twitterLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        twitterLoginButton.layer.cornerRadius = 5.0
        twitterLoginButton.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginClicked(sender: UIButton) {
        println("Twitter Login Clicked")
        
        TwitterClient.sharedInstance.loginWithCompletion(){
            
            (user: User?, error: NSError?) in
            
            if user != nil{
                //perform segue
                println("login success : \(user?.name)")
                
                //self.performSegueWithIdentifier("loginSegue", sender: self)
                
                self.initializeDrawerViewcontroller()
                
                
            }else{
                //handle login error
                println("error while login : \(error)")
            }
        }
        
    }
    
    
    func initializeDrawerViewcontroller(){
        
        var window: UIWindow?
        var drawerViewController: MMDrawerController?
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //contentviewcontroller
        
        var sidebarViewController = storyboard.instantiateViewControllerWithIdentifier("sidebarviewcontroller") as SidebarViewController
        
        var contentViewController = storyboard.instantiateViewControllerWithIdentifier("contentviewcontroller") as ViewController
        
        var loginViewController = storyboard.instantiateViewControllerWithIdentifier("loginviewcontroller") as LoginViewController
        
        drawerViewController = MMDrawerController(centerViewController: contentViewController, leftDrawerViewController: sidebarViewController)
        
        drawerViewController?.setMaximumLeftDrawerWidth(240.0, animated: true, completion: nil)
        drawerViewController?.openDrawerGestureModeMask = MMOpenDrawerGestureMode.All
        drawerViewController?.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.All
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = drawerViewController
        
    }
    
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    
    
}
