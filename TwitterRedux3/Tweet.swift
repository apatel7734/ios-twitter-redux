//
//  Tweet.swift
//  ios-twitter-client
//
//  Created by Ashish Patel on 9/25/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import Foundation

class Tweet{
    
    init(){
        
    }
    
    var text: String?
    var retweetCount: Int?
    var retweeted: Bool?
    //default : Mon Sep 29 03:26:04 +0000 2014
    var createdAt: String?
    // 1h, 2h , 2d, 3d etc...
    var timeAgoDate: String?
    //
    var favorited: Bool?
    var user: User?
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        retweetCount = dictionary["retweet_count"] as? Int
        createdAt = dictionary["created_at"] as? String
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        if let dateString = createdAt{
            var date = formatter.dateFromString(dateString)
            timeAgoDate = date?.timeAgo()
        }
        
        favorited = dictionary["favorited"] as? Bool
        
        user = User(dictionary: dictionary["user"] as NSDictionary)
    }
    
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for tweetDictionary in array{
            tweets.append(Tweet(dictionary: tweetDictionary))
        }
        
        return tweets
    }
}