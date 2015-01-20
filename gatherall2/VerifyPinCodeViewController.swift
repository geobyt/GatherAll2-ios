//
//  VerifyPinCodeViewController.swift
//  gatherall2
//
//  Created by George on 1/19/15.
//  Copyright (c) 2015 George. All rights reserved.
//

import Foundation

class VerifyPinCodeViewController : UIViewController
{
    var username : String = ""
    var phone: String = ""
    
    @IBOutlet weak var verifyButton : UIButton!
    @IBOutlet weak var pinCodeTextField : UITextField!
    
    override func viewDidLoad()
    {
        verifyButton.addTarget(self, action: "verify:", forControlEvents: UIControlEvents.TouchDown)
    }
    
    
    func verify(sender: UIButton!)
    {
        PFCloud.callFunctionInBackground("verifyWithCode", withParameters: [ "pinCode": pinCodeTextField.text, "username": username])
        {
            (succeeded: AnyObject!, err: NSError!) -> Void in
            if let password = succeeded as String!
            {
                if err == nil
                {
                    PFUser.logInWithUsernameInBackground(self.username, password: password)
                    {
                        (user: PFUser!, err: NSError!) -> Void in
                        
                        if err == nil
                        {
                            NSLog("SUCCESS LOGGING IN!")
                            
                            dispatch_async(dispatch_get_main_queue())
                            {
                                //self.performSegueWithIdentifier("returnHomeSegue", sender: self)
                            }
                        }
                    }
                }
            }
        }
    }
}
