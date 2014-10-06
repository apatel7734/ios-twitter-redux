//
//  User.swift
//  ios-twitter-client
//
//  Created by Ashish Patel on 9/25/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import Foundation

var _currentUser: User?
let currentUserKey = "current_user_key"
let userDidLoginNotification = "userDidLoginNotificaiton"
let userDidLogoutNotification = "userDidLogoutNotificaiton"

class User {
    
    
    var name: String?
    var screenName: String?
    var profileImageUrl: String?
    var tagLine: String?
    var dictionary: NSDictionary?
    var followersCount: Int?
    var backgroundImageUrl: String?
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagLine = dictionary["description"] as? String
        followersCount = dictionary["followers_count"] as? Int
        backgroundImageUrl = dictionary["profile_background_image_url"] as? String
    }
    
    
    func logout(){
        User.currentUser = nil
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    
    class var currentUser: User? {
        get{
        if(_currentUser == nil){
        var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
        if (data != nil){
        var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary
        _currentUser = User(dictionary: dictionary)
        }
        }
        return _currentUser
        }
        
        set(user){
            _currentUser = user
            
            if(_currentUser != nil){
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                
            }else{
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
        
    }
    
}