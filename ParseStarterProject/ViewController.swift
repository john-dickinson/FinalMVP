//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//


import UIKit
import Foundation
import Parse
import CoreData
import MobileCoreServices
import Bolts
import Parse

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            println("Object has been saved.")
        }
    }
    
    func signUpViewController(signUpController: PFSignUpViewController!, didSignUpUser user: PFUser!) {
        var account = PFObject(className: "transactions")
        account["accountholder"] = PFUser.currentUser()
        user.saveInBackgroundWithBlock{(success:Bool!,error:NSError!)->Void in
        
            if success != nil {
                NSLog("%@", "Success")
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                NSLog("%@", error)
            }
            
        }
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        if PFUser.currentUser() == nil {
            let login = PFLogInViewController()
            let signup = PFSignUpViewController()
            login.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.SignUpButton | PFLogInFields.LogInButton | PFLogInFields.PasswordForgotten
            
            login.delegate = self
            signup.delegate = self
            
            login.signUpController = signup
            self.presentViewController(login, animated: true, completion: nil)
        }
        else {
            var username = PFUser.currentUser().username
        }
    }
}

