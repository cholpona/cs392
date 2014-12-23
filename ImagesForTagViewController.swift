//
//  ImagesForTagViewController.swift
//  InsTag
//
//  Created by student8 on 21/12/14.
//  Copyright (c) 2014 student8. All rights reserved.
//

import UIKit

class ImagesForTagViewController: UIViewController,UICollectionViewDataSource{
    var json: [[String: AnyObject]]!
    var tagName : String!
    @IBOutlet weak var collectionView: UICollectionView!
    var entries : NSDictionary!
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(json == nil){
            return 0;
        }
        else{
            return json.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as UICollectionViewCell
       
//            let cellInfo = self.json[indexPath.item]
//            let images = cellInfo["images"]! as [String: AnyObject]
//            let lowresolution = images["low_resolution"]! as [String: String]
//            let url = lowresolution["url"]
//            let nsurl = NSURL(string: url!)
//            let nsdata = NSData(contentsOfURL: nsurl!)
//            let image = UIImage(data: nsdata!)
//            let imageView = cell.viewWithTag(99) as UIImageView
//            
//                            imageView.image = image
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), { () -> Void in
        
        let cellInfo = self.json[indexPath.item]
        let images = cellInfo["user"]! as [String: String]
        let url = images["profile_picture"]
        let nsurl = NSURL(string: url!)
        let nsdata = NSData(contentsOfURL: nsurl!)
        let image = UIImage(data: nsdata!)
        let imageView = cell.viewWithTag(99) as UIImageView
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            imageView.image = image
        })
        
        
     
        //b444440e51b943318d60cd4b34a0cb08
        //code
        //d45bc3d951d54c869b8a9a0e21186862
        //working access token 
        //583685231.1fb234f.ddba925fe0dd43089d69d6c414657ddb
        
        })
 
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJsnData("ozyegin")
        collectionView.reloadData()
    
    }
    
    func fetchJsnData(key : String){
        let urljson1 = "https://api.instagram.com/v1/tags/"+key+"/media/recent?access_token=583685231.1fb234f.ddba925fe0dd43089d69d6c414657ddb"
        let nsurljson = NSURL(string: urljson1)
        let nsdata = NSData(contentsOfURL: nsurljson!)
        entries = NSJSONSerialization.JSONObjectWithData(nsdata!, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSDictionary
        json = entries["data"] as [[String: AnyObject]]
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as UICollectionViewCell
        let indexPath = collectionView.indexPathForCell(cell)
        let cellInfo = json[indexPath!.item]
        let images = cellInfo["user"]! as [String: String]
        let url = images["profile_picture"]
//        let nsurl = NSURL(string: url!)
//        let nsdata = NSData(contentsOfURL: nsurl!)
//        let image = UIImage(data: nsdata!)
//        let imageView = cell.viewWithTag(10) as UIImageView
//        imageView.image = image
        let ImageVC = segue.destinationViewController as ImageViewController
        ImageVC.url = url
        
    }

}