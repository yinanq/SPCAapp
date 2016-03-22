//
//  Login2ViewController.swift
//  SPCAapp
//
//  Created by Fremling, Alicia (Contractor) on 3/7/16.
//  Copyright © 2016 AliciaAndYinan. All rights reserved.
//

import UIKit

class Login2ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signInActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var loginButtonView: UIView!
    var buttonViewInitialY: CGFloat!
    var buttonviewOffset: CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // makes emailTextfield active when the view loads
        emailTextField.becomeFirstResponder()
        
        // sets the initial position of of the loginButtonView
        buttonViewInitialY = loginButtonView.frame.origin.y
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // function for when the keyboard hides
    func keyboardWillShow(notification: NSNotification!) {
        let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
        
        if  loginButtonView.frame.origin.y != buttonViewInitialY - keyboardSize!.height {
            loginButtonView.frame.origin.y = buttonViewInitialY - keyboardSize!.height
        }
        
    }
    
    // function for when the keyboard hides
    func keyboardWillHide(notification: NSNotification!) {
        let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()

        if  self.loginButtonView.frame.origin.y != self.buttonViewInitialY {
            self.loginButtonView.frame.origin.y = buttonViewInitialY
        }
    }
    // function to get the return key to move to the next text field
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == emailTextField {
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
            performSegueWithIdentifier("logInSegue", sender: self)
        }
        
        return true
    }
    
    // function to check username and password
    @IBAction func didPressLoginButton(sender: AnyObject) {
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            showAlertWithTitle("Email & Password Required", andMessage: "Please enter an email address and password.")
        }
        else {
            signInActivityIndicator.startAnimating()
            delay(1) {
                if self.emailTextField.text == "em" && self.passwordTextField.text == "pw" {
                    self.signInActivityIndicator.stopAnimating()
                    self.performSegueWithIdentifier("logInSegue", sender: self)
                }
                else {
                    self.signInActivityIndicator.stopAnimating()
                    self.showAlertWithTitle("Invalid Email or Password", andMessage: "Please check the email and password combination.")
                }
            }
        }
    }
    
    // setting up the alert and style
    func showAlertWithTitle(title: String, andMessage message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel){ (action) in }
        alert.addAction(cancelAction)
        presentViewController(alert, animated: true){}
    }
    
    // function to create the login simulation delay
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    // function for tap gesture to dismiss keyboard when tapping outside of the text field
    @IBAction func onTap(sender: AnyObject) {
        
        // this actually hides the keyboard
        view.endEditing(true)
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
