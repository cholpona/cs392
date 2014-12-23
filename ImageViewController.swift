//
//  ImageViewController.swift
//  InsTag
//
//  Created by student8 on 21/12/14.
//  Copyright (c) 2014 student8. All rights reserved.
//
import UIKit

class ImageViewController: UIViewController{
    var url:String!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nsurl = NSURL(string: url!)
        let nsdata = NSData(contentsOfURL: nsurl!)
        let image1 = UIImage(data: nsdata!)
        imageView.image = image1
        
    }
    override func viewDidAppear(animated: Bool) {
        let nsurl = NSURL(string: url!)
        let nsdata = NSData(contentsOfURL: nsurl!)
        let image1 = UIImage(data: nsdata!)
        imageView.image = image1
    }
    ///chg
    
}