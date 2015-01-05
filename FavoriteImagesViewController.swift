//
//  FavoriteImagesViewController.swift
//  InsTag
//
//  Created by student8 on 29/12/14.
//  Copyright (c) 2014 student8. All rights reserved.
//

import UIKit

class FavoriteImagesViewController : UIViewController,UICollectionViewDataSource{
    var json: [[String: AnyObject]]!
    var entries : NSDictionary!
    
    @IBOutlet weak var collectionView: UICollectionView!
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(json == nil){
            return 0;
        }
        else{
            return json.count
        }
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellInFavorites", forIndexPath: indexPath) as UICollectionViewCell
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), { () -> Void in
            let cellInfo = self.json[indexPath.item]
            if let img : AnyObject = cellInfo["images"]{
                let images = img as [String:AnyObject]
                if let lowres : AnyObject = images["low_resolution"]{
                    let lowresolution = lowres as [String:AnyObject]
                    
                    if let urltemp : AnyObject = lowresolution["url"]{
                        let url = urltemp as String
                        let nsurl = NSURL(string: url)
                        let nsdata = NSData(contentsOfURL: nsurl!)
                        let image = UIImage(data: nsdata!)
                        let imageView = cell.viewWithTag(300) as UIImageView
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            imageView.image = image
                        })
                        
                        
                    }
                }
                
            }
            
        })
        
        return cell
    }
    func fetchJsnData(){
        let urljson1 = "https://api.instagram.com/v1/users/self/media/liked?access_token=583685231.1fb234f.ddba925fe0dd43089d69d6c414657ddb&count=35"
        let nsurljson = NSURL(string: urljson1)
        let nsdata = NSData(contentsOfURL: nsurljson!)
        entries = NSJSONSerialization.JSONObjectWithData(nsdata!, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSDictionary
        if let jsn : AnyObject = entries["data"]{
            json = jsn as [[String: AnyObject]]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), { () -> Void in
            self.fetchJsnData()
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.collectionView.reloadData()
               
            })
            
        })
    }
    override func viewDidAppear(animated: Bool) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), { () -> Void in
            self.fetchJsnData()
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.collectionView.reloadData()
                
            })
            
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        
        let ImageVC = segue.destinationViewController as ImageViewController
        let cell = sender as UICollectionViewCell
        let indexPath = collectionView.indexPathForCell(cell)
        let cellInfo = json[indexPath!.item]
        if let img : AnyObject = cellInfo["images"]{
            let images = img as [String:AnyObject]
            if let lowres : AnyObject = images["low_resolution"]{
                let lowresolution = lowres as [String:AnyObject]
                
                if let urltemp : AnyObject = lowresolution["url"]{
                    let urlImage = urltemp as String
                    ImageVC.url = urlImage
                }
            }
            
            
        }
        
        
        
        
        
        
        
        
        let user = cellInfo["user"]! as [String: String]
        let urlUserImage = user["profile_picture"]
        let userName = user["username"]
        var captionText = ""
        if let cap : AnyObject = cellInfo["caption"]{
            let caption = cap as [String:AnyObject]
            if let capText:AnyObject = caption["text"]{
                captionText = capText as String            }
            
            
        }
        //        let nsurl = NSURL(string: url!)
        //        let nsdata = NSData(contentsOfURL: nsurl!)
        //        let image = UIImage(data: nsdata!)
        //        let imageView = cell.viewWithTag(10) as UIImageView
        //        imageView.image = image
        
        ImageVC.userImageUrl = urlUserImage
        ImageVC.userName = userName
        ImageVC.captionText = captionText
        
    }
    
    
}

