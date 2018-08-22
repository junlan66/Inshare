//
//  signUpVC.swift
//  Inshare
//
//  Created by Junlan Lu on 8/13/18.
//  Copyright © 2018 Junlan Lu. All rights reserved.
//

import UIKit

class signUpVC: UIViewController {

    // profile image
    @IBOutlet weak var avaImg: UIImageView!
    // textfield
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var fullbaneTxt: UITextField!
    @IBOutlet weak var bioTxt: UITextField!
    @IBOutlet weak var webTxt: UITextField!
    //button
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    //scrollView
    @IBOutlet weak var scrollView: UIScrollView!
    //reset scroll view to default size
    var scrollViewHeight: CGFloat = 0
    //keyboard frame size
    var keyboard = CGRect()
    //deault func
    override func viewDidLoad() {
        super.viewDidLoad()
        // scrollview frame size
        scrollView.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.frame.width, height: self.view.frame.width)) //diff
        scrollView.contentSize.height = self.view.frame.height
        scrollViewHeight = scrollView.frame.size.height

        //check notification if keyboard is shown or not
        
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: .UIKeyboardWillHide, object: nil)
       
        // declare hide keyboard tap
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardTap))

        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
    }
    // hide keyboard if tapped
    @objc func hideKeyboardTap(recoginizer:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    //show keyboard function
    @objc func showKeyboard(_ notification: NSNotification){
        //define keyboard size
        keyboard = ((notification.userInfo?[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue)! // diff
        UIView.animate(withDuration: 0.4){ ()->Void in
            self.scrollView.frame.size.height = self.scrollViewHeight - self.keyboard.height
        }
    }
    //hide keyboard functtion
    @objc func hideKeyboard(_ notification: NSNotification){
        //move down UI
        UIView.animate(withDuration: 0.4) { ()->Void in
            self.scrollView.frame.size.height = self.view.frame.height
        }
    }
    
    //clicked sign up
    @IBAction func signUpBtn_click(_ sender: AnyObject) {
        print("sign up pressed")
    }
    //clicked cancel
    @IBAction func cancelBtn_click(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
