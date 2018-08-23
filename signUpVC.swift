//
//  signUpVC.swift
//  Inshare
//
//  Created by Junlan Lu on 8/13/18.
//  Copyright © 2018 Junlan Lu. All rights reserved.
//

import UIKit
import Parse

class signUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // profile image
    @IBOutlet weak var avaImg: UIImageView!
    // textfield
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
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
        scrollView.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.frame.width, height: self.view.frame.height)) //diff
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
        
        // round ava
        avaImg.layer.cornerRadius = avaImg.frame.size.width / 2
        avaImg.clipsToBounds = true
        
        // declare select image tap
        let avaTap = UITapGestureRecognizer (target: self, action: #selector(loadImg))
        avaTap.numberOfTapsRequired = 1
        avaImg.isUserInteractionEnabled = true
        avaImg.addGestureRecognizer(avaTap)

        
    }
    
    // call picker to select image
    @objc func loadImg(recoginizer:UITapGestureRecognizer){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        avaImg.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
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
        // dismiss keyboard
        self.view.endEditing(true)
        // if field is empty
        if (usernameTxt.text!.isEmpty || passwordTxt.text!.isEmpty || repeatPassword.text!.isEmpty || fullbaneTxt.text!.isEmpty || bioTxt.text!.isEmpty || webTxt.text!.isEmpty){
            // alart message
            let alart = UIAlertController(title: "PLEASE", message: "fill in all fileds", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction (title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alart.addAction(ok)
            self.present(alart, animated: true, completion: nil)
        }
        // if passwords do not match
        if passwordTxt.text != repeatPassword.text {
            // alart message
            let alart = UIAlertController(title: "PASSWORDS", message: "do not match", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction (title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alart.addAction(ok)
            self.present(alart, animated: true, completion: nil)
        }
        //send data to server to relate column
        let user = PFUser()
        user.username = usernameTxt.text?.lowercased()
        user.email = emailTxt.text?.lowercased()
        user.password = passwordTxt.text?.lowercased()
        user["fullname"] = fullbaneTxt.text?.lowercased()
        user["bio"] = bioTxt.text?.lowercased()
        user["web"] = webTxt.text?.lowercased()
        // it's gonna be assigned in edit profile
        user["tel"] = ""
        user["gender"] = ""
        //convert our image for sending to server
        let avaData = UIImageJPEGRepresentation(avaImg.image!, 0.5)
        let avaFile = PFFile(name: "ava.jpg", data: avaData!)
        user["ava"] = avaFile
        
        //save data in server
        user.signUpInBackground { (success: Bool, error: Error?) -> Void in
            if success{
                print ("registered")
            } else{
                print ("error?.localizedDescription")
            }
        }
        
    }
    //clicked cancel
    @IBAction func cancelBtn_click(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
