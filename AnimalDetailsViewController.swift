//
//  AnimalDetailsViewController.swift
//  SPCAapp
//
//  Created by Yinan Motiv on 3/14/16.
//  Copyright © 2016 AliciaAndYinan. All rights reserved.
//

import UIKit

class AnimalDetailsViewController: UIViewController {

    var animalName: String!
    @IBOutlet weak var navItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navItem.title = "Dog!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
