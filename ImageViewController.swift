//
//  ImageViewController.swift
//  InsTag
//
//  Created by student8 on 23/12/14.
//  Copyright (c) 2014 student8. All rights reserved.
//

import UIKit
class ImageViewController : UIViewController{
    var url : String!
    var userImageUrl: String!
    var userName : String!
    var captionText : String!
    var userID : String!
    var json: [String: AnyObject]!
    var entries : NSDictionary!


    
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameTextLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let nsurl = NSURL(string: url) {
            if let nsdata = NSData(contentsOfURL: nsurl) {
                imageView.image = UIImage(data: nsdata)
            }
        }
        if let nsurl = NSURL(string: userImageUrl) {
            if let nsdata = NSData(contentsOfURL: nsurl) {
                userProfileImageView.image = UIImage(data: nsdata)
            }
        }
        userNameTextLabel.text = userName
        caption.text = captionText
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let userProfileVC = segue.destinationViewController as UserProfileViewController
        userProfileVC.userName = userName
        userProfileVC.userPhotoUrl = userImageUrl
        let url = "https://api.instagram.com/v1/users/"+userID+"/?access_token=583685231.1fb234f.ddba925fe0dd43089d69d6c414657ddb"
        let nsurljson = NSURL(string: url)
        let nsdata = NSData(contentsOfURL: nsurljson!)
        entries = NSJSONSerialization.JSONObjectWithData(nsdata!, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSDictionary
        if let jsn : AnyObject = entries["data"]{
            json = jsn as [String: AnyObject]
        }
        if let countsT : AnyObject = json["counts"]{
            let counts = countsT as [String:AnyObject]
            if let followerstemp : AnyObject = counts["followed_by"]{
                let followers = followerstemp as String
                userProfileVC.followers = followers
            }
            if let followingstemp : AnyObject = counts["follows"]{
                let followings = followingstemp as String
                userProfileVC.following = followings
            }
            if let mediaTemp : AnyObject = counts["media"]{
                let media = mediaTemp as String
                userProfileVC.posts = media
            }
            
        }
        
        
        
    }

}
