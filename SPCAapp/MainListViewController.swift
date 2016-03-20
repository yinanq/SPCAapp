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
    @IBOutlet weak var endShiftButtonView: UIView!
    
//    let tempNumberOfRowsInSection = 5
    var animalNames = ["Steffi", "Kelly", "Cloud", "Gold", "Harlowe"]
    var animalPhotos = [UIImage(named: "photoOfDogSteffi"), UIImage(named: "photoOfDogKelly"), UIImage(named: "photoOfDogCloud"), UIImage(named: "photoOfDogGold"), UIImage(named: "photoOfDogHarlowe")]
    var colorCodeColors = [greenLevelColor,greenLevelColor,yellowLevelColor,puppiesColor,targetColor]
    var hoursSinceLastVist = [3.6, 3.2, 1.9, 0.7, 0.2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainlistTableView.delegate = self
        mainlistTableView.dataSource = self
        
        endShiftButtonView.layer.cornerRadius = 19
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // remove the shallow line at bottom of navbar
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = UIImage();
    }
    
    // MARK: - TableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animalNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("Row: \(indexPath.row)")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("AnimalCell") as! AnimalCell
        
        cell.animalNameLabel.text = animalNames[indexPath.row]
        cell.photoImageView.image = animalPhotos[indexPath.row]
        cell.photoImageView.layer.borderColor = colorCodeColors[indexPath.row].CGColor
        cell.hoursSinceLastVisitLabel.text = "\(hoursSinceLastVist[indexPath.row])"
        if hoursSinceLastVist[indexPath.row] > 1 {
            cell.hrOrHrsLabel.text = "hrs since last visit"
        } else {
            cell.hrOrHrsLabel.text = "hr since last visit"
        }
        
        return cell
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let cell = sender as! UITableViewCell
        let indexPath = mainlistTableView.indexPathForCell(cell)!
        
        let animalName = animalNames[indexPath.row]
        let animalPhoto = animalPhotos[indexPath.row]
        
        let destinationViewController = segue.destinationViewController as! AnimalDetailsViewController
        
        destinationViewController.animalName = animalName
        destinationViewController.animalPhoto = animalPhoto
    }
}
