//
//  AddDishViewController.swift
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

class AddDishViewController: UIViewController{

    @IBOutlet weak var dishName: UITextField!
    
    @IBOutlet weak var dishDesc: UITextField!
    
    @IBAction func cancelDish(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func addDish(sender: AnyObject) {
        var dish = dishName.text
        var desc = dishDesc.text
        var dishes = PFObject(className: "dishes")
        dishes["dish"] = dish
        dishes["description"] = desc
        dishes["accountholder"] = PFUser.currentUser()
        
        dishes.saveInBackgroundWithBlock{(success:Bool!,error:NSError!)->Void in
            
            if success != nil {
                NSLog("%@", "Dish saved Successfully")
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                NSLog("%@", error)
            }
            
            let currentDish = NSString(string:self.dishName.text!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var user = PFUser.currentUser()
        var query = PFQuery(className: "dishes")
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
