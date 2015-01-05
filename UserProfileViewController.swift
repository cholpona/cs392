//
//  UserProfileViewController.swift
//  InsTag
//
//  Created by student8 on 05/01/15.
//  Copyright (c) 2015 student8. All rights reserved.
//

import UIKit

class UserProfileViewController : UIViewController{
    
    var followers : String!
    var following : String!
    var posts: String!
    var userPhotoUrl : String!
    var userName : String!

    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var postsLabel: UILabel!

    @IBOutlet weak var followersLabel: UILabel!

    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var isFollowingLabel: UILabel!
    
    @IBOutlet weak var isFollowYouLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let nsurl = NSURL(string: userPhotoUrl) {
            if let nsdata = NSData(contentsOfURL: nsurl) {
                profileImage.image = UIImage(data: nsdata)
            }
        }
        followingLabel.text = following
        followersLabel.text = followers
        postsLabel.text = posts
        
        
        
        
    
    }
}