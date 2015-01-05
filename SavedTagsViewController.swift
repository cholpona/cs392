//
//  SavedTagsViewController.swift
//  InsTag
//
//  Created by student8 on 21/12/14.
//  Copyright (c) 2014 student8. All rights reserved.
//

import UIKit

class SavedTagsViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var tags: [String]!
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        if textField.text != "" {
            tags.append(textField.text)
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setObject(tags, forKey: "tags")
            tableView.reloadData()
            textField.text = ""
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tagCell") as UITableViewCell
        cell.textLabel.text = tags[indexPath.item]
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            
            tags.removeAtIndex(indexPath.item)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setObject(tags, forKey: "tags")
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let defaultItems = userDefaults.arrayForKey("tags") {
            tags = defaultItems as [String]
        } else {
            tags = [String]()
            userDefaults.setObject(tags, forKey: "tags")
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        //NSLog("%s", cell.description)
        NSLog("selected tag is = %@",cell.textLabel.text!)
       
        let ImagesForTagVC = segue.destinationViewController as ImagesForTagViewController
        ImagesForTagVC.tagName = cell.textLabel.text!
        

    }
    override func viewDidAppear(animated: Bool) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let defaultItems = userDefaults.arrayForKey("tags") {
            tags = defaultItems as [String]
        } else {
            tags = [String]()
            userDefaults.setObject(tags, forKey: "tags")
        }
         tableView.reloadData()
    }
   
 
}
