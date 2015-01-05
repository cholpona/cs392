//
//  SearchViewController.swift
//  InsTag
//
//  Created by student8 on 24/12/14.
//  Copyright (c) 2014 student8. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UISearchBarDelegate, UICollectionViewDataSource{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var json:[[String: AnyObject]]!
    var entries : NSDictionary!

    @IBAction func followButtonTapped(sender: AnyObject) {
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(json ==  nil){
            return 0;
        }
        else{
            return json.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //to be implemented
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCellInSearch", forIndexPath: indexPath) as UICollectionViewCell
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
                        let imageView = cell.viewWithTag(199) as UIImageView
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            imageView.image = image
                        })
                        
                    }
                }
                
            }
            
        })
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        
    }
    func fetchJsnData(key : String){
        
        let urljson1 = "https://api.instagram.com/v1/tags/"+key+"/media/recent?access_token=583685231.1fb234f.ddba925fe0dd43089d69d6c414657ddb"
        let nsurljson = NSURL(string: urljson1)
        let nsdata = NSData(contentsOfURL: nsurljson!)
        entries = NSJSONSerialization.JSONObjectWithData(nsdata!, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSDictionary
        if let jsn : AnyObject = entries["data"]{
            json = jsn as [[String: AnyObject]]
        }
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), { () -> Void in
           self.fetchJsnData(self.searchBar.text)
             NSLog("selected tag is = %@",self.searchBar.text)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.collectionView.reloadData()
                NSLog("%s","aa")
            })
            
        })
//        self.fetchJsnData(self.searchBar.text)
//        self.collectionView.reloadData()
//        NSLog("%s","aa")
        
        
    }
    
}