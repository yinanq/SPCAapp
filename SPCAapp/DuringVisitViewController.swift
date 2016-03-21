//
//  DuringVisitViewController.swift
//  SPCAapp
//
//  Created by Yinan Motiv on 3/20/16.
//  Copyright © 2016 AliciaAndYinan. All rights reserved.
//

import UIKit

class DuringVisitViewController: UIViewController {

    @IBOutlet weak var visitTitle: UILabel!
    @IBOutlet weak var animalPhoto: UIImageView!
    @IBOutlet weak var animalName: UILabel!
    @IBOutlet weak var roomNumber: UILabel!
    @IBOutlet weak var endVisitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        endVisitButton.layer.cornerRadius =  endVisitButton.frame.width/2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapAndHoldEndVisitButton(sender: AnyObject) {
        print("press holding")
        endVisitButton.frame = CGRectMake(120, 300, 500, 500)
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
