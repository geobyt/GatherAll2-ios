//
//  LoginViewController.swift
//  gatherall2
//
//  Created by George on 1/19/15.
//  Copyright (c) 2015 George. All rights reserved.
//

import Foundation

class LoginViewController : UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var nextButton : UIButton!
    @IBOutlet weak var phoneTextField : UITextField!
    @IBOutlet weak var nameTextField : UITextField!
    
    override func viewDidLoad()
    {
        phoneTextField.delegate = self
        nameTextField.delegate = self
        nextButton.addTarget(self, action: "next:", forControlEvents: UIControlEvents.TouchDown)
    }
    
    func next(sender: UIButton!)
    {
        PFCloud.callFunctionInBackground("inviteWithSMS", withParameters: ["phone": phoneTextField.text, "username": nameTextField.text])
        {
            (succeeded: AnyObject!, err: NSError!) -> Void in
            if err == nil
            {
                dispatch_async(dispatch_get_main_queue())
                {
                    self.performSegueWithIdentifier("verifyPinCodeSegue", sender: self)
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "verifyPinCodeSegue"
        {
            var vc = segue.destinationViewController as VerifyPinCodeViewController
            vc.username = nameTextField.text
            vc.phone = phoneTextField.text
        }
    }
}
