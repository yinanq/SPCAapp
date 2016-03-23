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
    
    var passedAnimalPhoto: UIImage!
    @IBOutlet weak var animalPhoto: UIImageView!
    var passedAnimalName: String!
    @IBOutlet weak var animalName: UILabel!
    var passedDuration: String!
    @IBOutlet weak var duration: UILabel!
//    var passedStartTime: String!
//    @IBOutlet weak var startTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animalPhoto.image = passedAnimalPhoto
        animalName.text = passedAnimalName
        duration.text = passedDuration
        
        visitSummaryScrollView.delegate = self
        visitSummaryScrollView.contentSize = CGSize (width: 320, height: 600)
        // visitSummaryScrollView.delegate = self
        behaviorTextField.delegate = self
        symptomTextField.delegate = self
        
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
    
    @IBAction func symptomNotesDidBeginEditing(sender: AnyObject) {
        UIView.animateWithDuration(0.3) { () -> Void in
            self.visitSummaryScrollView.contentOffset.y = 80
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == behaviorTextField {
            behaviorTextField.resignFirstResponder()
            symptomTextField.becomeFirstResponder()
//            CGPoint point = symptomTextfield.frame.origin ;
//            scrollView.contentOffset = point
        }
        else if textField == symptomTextField {
            symptomTextField.resignFirstResponder()
            performSegueWithIdentifier("fromVisitSummaryForm", sender: self)
        }
        return true
    }
    
    // hides keyboard when if the user is in a text field and scrolls down
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "fromVisitSummaryForm" {
            // Get the new view controller using segue.destinationViewController.
            
//            let destinationViewController = segue.destinationViewController as! MainListViewController
            // http://stackoverflow.com/questions/30209626/could-not-cast-value-of-type-uinavigationcontroller
            let destinationViewControllerParent = segue.destinationViewController as! UINavigationController
            let destinationViewController = destinationViewControllerParent.topViewController as! MainListViewController
            
            // Pass the selected object to the new view controller.
            var behaviorNotes: String!
            if behaviorTextField.text == nil {
                behaviorNotes = "N/A"
            } else {
                behaviorNotes = ("\(behaviorTextField.text!)")
            }
            var symptomNotes: String!
            if symptomTextField.text == nil {
                symptomNotes = "N/A"
            } else {
                symptomNotes = ("\(symptomTextField.text!)")
            }
            
            destinationViewController.hasNewVisitToAdd = true
            destinationViewController.newlyVisitedAnimal = passedAnimalName
            destinationViewController.newBehaviorNotes = behaviorNotes
            destinationViewController.newSymptomNotes = symptomNotes
        }
    }

}
