//
//  resetPasswordVC.swift
//  Inshare
//
//  Created by Junlan Lu on 8/13/18.
//  Copyright © 2018 Junlan Lu. All rights reserved.
//

import UIKit
import Parse

class resetPasswordVC: UIViewController {
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var CancelBtn: UIButton!
    // clicked rest button
    @IBAction func restBtn_click(_ sender: AnyObject) {
        // hide keyboard
        self.view.endEditing(true)
        //show alert message
        if emailTxt.text!.isEmpty{
            // show alart message
            let alart = UIAlertController(title: "Email field", message: "is empty", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction (title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alart.addAction(ok)
            self.present(alart, animated: true, completion: nil)
        }
        // request for resettting password
        PFUser.requestPasswordResetForEmail(inBackground: emailTxt.text!)  { (success, error) -> Void in // success / error ???
            if success {
                let alart = UIAlertController(title: "Email for reseting password", message: "has be sent to textted email", preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction (title: "OK", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
                    self.dismiss(animated: true, completion: nil)
                })
                alart.addAction(ok)
                self.present(alart, animated: true, completion: nil)
            } else{
                print(error?.localizedDescription as Any)
            }
        }
    }
   
    // clicked cancel button
    @IBAction func cancelBtn_click(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
