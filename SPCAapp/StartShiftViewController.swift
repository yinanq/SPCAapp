//
//  StartShiftViewController.swift
//
//
//  Created by Fremling, Alicia (Contractor) on 3/20/16.
//
//

import UIKit

class StartShiftViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var locationPickerView: UIPickerView! = UIPickerView()
    @IBOutlet weak var startShiftButton: UIButton!
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationPickerView.alpha = 0
        locationPickerView.backgroundColor = UIColor.whiteColor()
        
        startShiftButton.backgroundColor = SPCABrandColor
        startShiftButton.layer.cornerRadius = 80
        
        self.locationTextField.delegate = self
        self.locationPickerView.delegate = self
        self.locationPickerView.dataSource = self
        
        pickerData = ["Mission Campus", "Pacific Heights Campus", "Humane Education & Dog Training"]

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
           UIView.animateWithDuration(0.3) { () -> Void in
            self.locationTextField.text = self.pickerData[row]
            self.locationPickerView.alpha = 0;
            self.locationTextField.alpha = 1
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        UIView.animateWithDuration(0.3) { () -> Void in
            self.locationPickerView.alpha = 1
            self.locationTextField.alpha = 0
        }
        return false
    }
    
    func showAlertWithTitle(title: String, andMessage message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel){ (action) in }
        alert.addAction(cancelAction)
        presentViewController(alert, animated: true){}
    }
    
    @IBAction func onStartShiftTap(sender: UIButton) {
        if locationTextField.text!.isEmpty {
            showAlertWithTitle("Location is Required", andMessage: "Please select a location.")
        }
        else {
            Shift.startTime = NSDate()
            performSegueWithIdentifier("fromStartShift", sender: self)
        }
        
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
