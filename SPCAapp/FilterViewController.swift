//
//  FilterViewController.swift
//  SPCAapp
//
//  Created by Fremling, Alicia (Contractor) on 3/23/16.
//  Copyright © 2016 AliciaAndYinan. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var filterScrollView: UIScrollView!
    @IBOutlet weak var filterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterScrollView.contentSize = filterImageView.image!.size

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButton(sender: AnyObject) {
//        performSegueWithIdentifier("backToAllDogs", sender: self)
        dismissViewControllerAnimated(true, completion: nil)
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
