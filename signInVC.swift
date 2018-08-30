//
//  signInVC.swift
//  Inshare
//
//  Created by Junlan Lu on 8/13/18.
//  Copyright © 2018 Junlan Lu. All rights reserved.
//

import UIKit
import Parse


class signInVC: UIViewController {
    //textfield
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    //buttons
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var forgotBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //clicked sign in button
    @IBAction func signInBtn_click(_ sender: AnyObject) {
        print("sign in pressed")
        // if textfile are empty
        if usernameTxt.text!.isEmpty || passwordTxt.text!.isEmpty{
            // show alart message
            let alart = UIAlertController(title: "please", message: "fill in field", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction (title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alart.addAction(ok)
            self.present(alart, animated: true, completion:nil)
        }
        // login function
        PFUser.logInWithUsername(inBackground: usernameTxt.text!, password:passwordTxt.text!) { (user: PFUser?, error: Error?) -> Void in

            if error == nil{
                // remember user or save in memeory did the user log in or not
                UserDefaults.standard.set(user!.username, forKey: "username") //diff
                UserDefaults.standard.synchronize() //diff
                
                // call login function from AppDelegate.swift class
                let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.login()
            }
        }
    }
}
