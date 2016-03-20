//
//  StartShiftViewController.swift
//
//
//  Created by Fremling, Alicia (Contractor) on 3/20/16.
//
//

import UIKit

class StartShiftViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var locationPickerView: UIPickerView!
    
    var pickerData: [String] = [String]()
    
//    var pickerData = ["Mission Campus", "Pacific Heights Campus", "Humane Education and Dog Training"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationPickerView.delegate = self
        self.locationPickerView.dataSource = self
        
        pickerData = ["Mission Campus", "Pacific Heights Campus", "Humane Education and Dog Training"]

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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
