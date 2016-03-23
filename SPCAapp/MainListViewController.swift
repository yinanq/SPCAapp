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
    @IBOutlet weak var shiftTimer: UILabel!
    @IBOutlet weak var shiftTimerView: UIView!
    @IBOutlet weak var mainlistTableView: UITableView!
    @IBOutlet weak var endShiftButtonView: UIView!
    
    // data passed from VisitSummaryViewController
    var newlyVisitedAnimal: String!
    var newBehaviorNotes: String!
    var newSymptomNotes: String!
    var hasNewVisitToAdd = false
    
    // establishes timer
    var mainShiftTimer = NSTimer()
    var startTime = NSTimeInterval()
    var shiftCounter = 0
    
    var animalNames = ["Steffi", "Kelly", "Cloud", "Gold", "Harlowe"]
    var animalPhotos = [UIImage(named: "photoOfDogSteffi"), UIImage(named: "photoOfDogKelly"), UIImage(named: "photoOfDogCloud"), UIImage(named: "photoOfDogGold"), UIImage(named: "photoOfDogHarlowe")]
    var colorCodeColors = [greenLevelColor,greenLevelColor,yellowLevelColor,puppiesColor,targetColor]
    var hoursSinceLastVist = [3.6, 3.2, 1.9, 0.7, 0.2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainlistTableView.delegate = self
        mainlistTableView.dataSource = self
        
        // details came from tutorial - don't understand. must be in view did load to maintain timer.
        let aSelector : Selector = "updateTime"
        mainShiftTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
        
        endShiftButtonView.layer.cornerRadius = 19
    }
    
    // calculates start time to be 00:00 and formats timer
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime: NSTimeInterval = currentTime - startTime
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        // actually makes the timer appear
        shiftTimer.text = "\(strMinutes):\(strSeconds)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // remove the shadow line at bottom of navbar
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
        
        if segue.identifier=="toPetPage" {
            let cell = sender as! UITableViewCell
            let indexPath = mainlistTableView.indexPathForCell(cell)!
            
            let animalName = animalNames[indexPath.row]
            let animalPhoto = animalPhotos[indexPath.row]
            
            let destinationViewController = segue.destinationViewController as! AnimalDetailsViewController
            
            destinationViewController.animalName = animalName
            destinationViewController.animalPhoto = animalPhoto
            
            // pass new visit notes if cell is of newly visited animal
            if hasNewVisitToAdd == true {
                if newlyVisitedAnimal == animalName {
                    destinationViewController.newBehaviorNotes = newBehaviorNotes
                    destinationViewController.newSymptomNotes = newSymptomNotes
                    destinationViewController.hasNewVisitToAdd = true
                }
            }
        }
        
    }
    
    // on tapping end shift button, timer recents and performs segue to start shift VC
    @IBAction func onEndShift(sender: AnyObject) {
        mainShiftTimer.invalidate()
        performSegueWithIdentifier("endShift", sender: self)
    }
}
