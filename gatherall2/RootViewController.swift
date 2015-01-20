//
//  RootViewController.swift
//  gatherall2
//
//  Created by George on 1/19/15.
//  Copyright (c) 2015 George. All rights reserved.
//

import Foundation

class RootViewController : UIViewController
{
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        if (PFUser.currentUser() != nil) {
            // This means user is logged in already
            dispatch_async(dispatch_get_main_queue())
            {
                self.performSegueWithIdentifier("showGatheringSegue", sender: self)
            }
        } else {
            // This means user needs to be presented with login screen flow
            dispatch_async(dispatch_get_main_queue())
            {
                self.performSegueWithIdentifier("loginScreenSegue", sender: self)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "loginScreenSegue"
        {
            var vc = segue.destinationViewController as LoginViewController
        }
        else if segue.identifier == "showGatheringSegue"
        {
            var vc = segue.destinationViewController as GatheringTableViewController
        }
    }
    
    @IBAction func unwindToRoot(segue: UIStoryboardSegue)
    {
        if PFUser.currentUser() != nil
        {
            dispatch_async(dispatch_get_main_queue())
            {
                self.performSegueWithIdentifier("showGatheringSegue", sender: self)
            }
        }
    }
}
