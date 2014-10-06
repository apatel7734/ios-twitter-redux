//
//  TwitterClient.swift
//  ios-twitter-client
//
//  Created by Ashish Patel on 9/25/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import Foundation

let TWITTER_API_KEY="ZJ19UrjUWj3cwx4XZ15g"
let TWITTER_API_SECRET="6PvCt2CFKbaDWP2LnJxqvUN16re4GBKw7fKRLCkSz8Q"

let TWITTER_TOKEN = "391152948-WEWBmRWUUBwblohQ8XzBtgYj3lI6p5gQtaPNNhrM"
let TWITTER_TOKEN_SECRET = "1sQZeHKD04YjvXwk61QIomaJ34ig9Z3kyuBYtix25U"
let TWITTER_BASE_URL = NSURL(string: "https://api.twitter.com")
let TWITTER_REQUEST_TOKEN =  "oauth/request_token"
let TWITTER_HOME_TIMELINE_URI = "statuses/home_timeline.json"

class TwitterClient: BDBOAuth1RequestOperationManager{
    
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    var homeTimelineCompletion: ((tweets: [Tweet]?, error: NSError?) -> ())?
    var tweetStatusCompletion: ((tweet: Tweet?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        
    struct Static{
        static let instance  = TwitterClient(baseURL: TWITTER_BASE_URL,consumerKey: TWITTER_API_KEY, consumerSecret: TWITTER_API_SECRET)
        }
        return Static.instance
    }
    
    
    //async get hometimeline tweets from API
    func getHomeTimeLineTweets(success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        
        return self.GET(TWITTER_HOME_TIMELINE_URI, parameters: nil, success: success, failure: failure)
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()){
        
        loginCompletion = completion
        
        //fetch request token & redirects to authorization webpage
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        fetchRequestTokenWithPath("oauth/request_token", method: "POST", callbackURL: NSURL(string: "mytwitterclientdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuthToken!) -> Void in
            
            println("request token")
            
            var authUrl = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authUrl)
            }) { (error: NSError!) -> Void in
                println("failled to get request token : \(error)")
                self.loginCompletion?(user: nil, error: error)
        }
        
    }
    
    /*
    func tweetStatus(status: String, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation!{
    var parameters = ["status" : status]
    return self.POST("1.1/statuses/update.json", parameters: parameters, success: success, failure: failure)
    }
    */
    
    func tweetStatusWithCompletion(completion: (tweet: Tweet?, error: NSError?) -> (), status: String){
        tweetStatusCompletion = completion
        
        var parameters = ["status" : status]
        //get user's timeline
        TwitterClient.sharedInstance.POST("1.1/statuses/update.json", parameters: parameters, success: { (requestOperation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            var tweet = Tweet(dictionary: response as NSDictionary)
            
            self.tweetStatusCompletion?(tweet: tweet, error: nil)
            
            }, failure: { (requestOperation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                
                println("Failed to post on your timeline \(error)")
                self.tweetStatusCompletion?(tweet: nil, error: nil)
        })   
    }
    
    
    func openUrl(url: NSURL){
        
        //fetch access token
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuthToken(queryString: url.query), success: { (accessToken: BDBOAuthToken!) -> Void in
            // successfully got the access token now save it.
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            //get current users information
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (requestOperation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                
                var user = User(dictionary: response as NSDictionary)
                //persist current logged in user
                User.currentUser = user
                //return to login completion block with logged in user
                self.loginCompletion?(user: user,error: nil)
                
                }, failure: { (requestOperation: AFHTTPRequestOperation!, error:NSError!) -> Void in
                    println("Failed to get current user \(error)")
                    self.loginCompletion?(user: nil, error: error)
            })
            
            }) { (error: NSError!) -> Void in
                println("Failed to get accesstoken \(error)")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    
    func getHomeTimeLineWithCompletion(completion: (tweets: [Tweet]?, error: NSError?) -> ()){
        
        self.homeTimelineCompletion = completion
        //get user's timeline
        TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (requestOperation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            println("home timeline response")
            var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
            self.homeTimelineCompletion?(tweets: tweets, error: nil)
            
            }, failure: { (requestOperation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Failed to get home timeline \(error)")
                self.homeTimelineCompletion?(tweets: nil, error: nil)
        })
    }
}
