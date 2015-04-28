//
//  TableViewController.swift
//  CookForMe
//
//  Created by John Dickinson on 4/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Foundation
import Parse
import CoreData
import MobileCoreServices

class TableViewController: UITableViewController, PFLogInViewControllerDelegate {

    
    
    var dishData:NSMutableArray = NSMutableArray()
    
    func loadData(){
        dishData.removeAllObjects()
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            var findDishData = PFQuery(className: "dishes")
            //findTransactionData.cachePolicy = kPFCachePolicyNetworkElseCache
            let isInCache = findDishData.hasCachedResult()
            findDishData.clearCachedResult()
            PFQuery.clearAllCachedResults()
            findDishData.maxCacheAge = 60 * 60 * 24
            findDishData.whereKey("accountholder", equalTo: currentUser)
            findDishData.orderByDescending("createdAt")
            findDishData.findObjectsInBackgroundWithBlock{(objects:[AnyObject]!,error:NSError!)->Void in
                
                if error == nil {
                    for object in objects {
                        self.dishData.addObject(object)
                    }
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        self.loadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Fetching dishes!")
        refresh.addTarget(self, action: "loadData", forControlEvents:.ValueChanged)
        self.refreshControl = refresh
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return dishData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellIdentifier = "CELL"
        let dishes: PFObject = self.dishData.objectAtIndex(indexPath.row) as PFObject
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        var transdata: AnyObject! = dishes["dish"]
        var dateUpdated = dishes.updatedAt as NSDate
        var dateFormat = NSDateFormatter()
        
        dateFormat.locale = NSLocale.currentLocale()
        dateFormat.dateFormat = "MM d, YYYY, hh:mm a"
        
        let str = NSString(format: "%.2f",transdata as Double)
        if let label = cell.textLabel {
            label.text = str + " " + NSString(format: "%@", dateFormat.stringFromDate(dateUpdated
                ).capitalizedString)
        }
        return cell
    }


    // MARK: - Table view data source

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
