//
//  VisitSummaryViewController.swift
//  SPCAapp
//
//  Created by Fremling, Alicia (Contractor) on 3/13/16.
//  Copyright © 2016 AliciaAndYinan. All rights reserved.
//

import UIKit

class VisitSummaryViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {

    @IBOutlet weak var behaviorTextField: UITextField!
    @IBOutlet weak var symptomTextField: UITextField!
    @IBOutlet weak var visitSummaryScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitSummaryScrollView.delegate = self
        visitSummaryScrollView.contentSize = CGSize (width: 320, height: 600)
        // visitSummaryScrollView.delegate = self
        behaviorTextField.delegate = self
        
        // makes emailTextfield active when the view loads
        behaviorTextField.becomeFirstResponder()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
    }
    
    // function for when the keyboard hides
    func keyboardWillHide(notification: NSNotification!) {
        let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
    }
    
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == behaviorTextField {
            behaviorTextField.resignFirstResponder()
            symptomTextField.becomeFirstResponder()
        }
        return true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView){
        if visitSummaryScrollView.contentOffset.y <= -10 {
            view.endEditing(true)
        }
    }

//    func scrollViewDidScroll(visitSummaryScrollView: UIScrollView){
//        if visitSummaryScrollView.contentOffset.y <= 10 {
//            // Hide the keyboard
//            view.endEditing(true)
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
