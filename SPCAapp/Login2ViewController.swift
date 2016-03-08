//
//  Login2ViewController.swift
//  SPCAapp
//
//  Created by Fremling, Alicia (Contractor) on 3/7/16.
//  Copyright © 2016 AliciaAndYinan. All rights reserved.
//

import UIKit

class Login2ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signInActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        
    }

    @IBAction func didPressLoginButton(sender: AnyObject) {
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            showAlertWithTitle("Email & Password Required", andMessage: "Please enter an email address and password.")
        } else {
            signInActivityIndicator.startAnimating()
            delay(1) {
                if self.emailTextField.text == "Email" && self.passwordTextField.text == "Password" {
                    self.signInActivityIndicator.stopAnimating()
                    self.performSegueWithIdentifier("signInButtonSegue", sender: self)
                } else {
                    self.signInActivityIndicator.stopAnimating()
                    self.showAlertWithTitle("Invalid Email or Password", andMessage: "Please check the email and password combination.")
                }
            }
        }
    }
    
    func showAlertWithTitle(title: String, andMessage message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel){ (action) in }
        alert.addAction(cancelAction)
        presentViewController(alert, animated: true){}
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
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
