//
//  MainListViewController.swift
//  SPCAapp
//
//  Created by Yinan Motiv on 3/13/16.
//  Copyright © 2016 AliciaAndYinan. All rights reserved.
//

import UIKit

class MainListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var filtersButton: UIButton!
    @IBOutlet weak var shiftTimerView: UIView!
    @IBOutlet weak var mainlistTableView: UITableView!
    
    let tempNumberOfRowsInSection = 5
    var animalNames = ["Steffi", "Kelly", "Cloud", "Gold", "Harlowe"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainlistTableView.delegate = self
        mainlistTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempNumberOfRowsInSection
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AnimalCell")! as UITableViewCell
        return cell
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
