//
//  MainListViewController.swift
//  SPCAapp
//
//  Created by Yinan Motiv on 3/13/16.
//  Copyright © 2016 AliciaAndYinan. All rights reserved.
//

import UIKit

class Shift {
    static var startTime : NSDate = NSDate()
    
    static func elapsedTime(now: NSDate) -> NSTimeInterval {
        return now.timeIntervalSinceDate(self.startTime)
    }
    
    static func formattedElapsedTime() -> String {
        var elapsed = self.elapsedTime(NSDate())
        let minutes = UInt8(elapsed / 60.0)
        elapsed -= (NSTimeInterval(minutes) * 60)
        let seconds = UInt8(elapsed)
        elapsed -= NSTimeInterval(seconds)
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        // actually makes the timer appear
        return "\(strMinutes):\(strSeconds)"
    }
}

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
        
        // using stupid manual code, if new visit happened move newly visited dog to bottom in table view list ordered from least to most recently visited dogs
        if hasNewVisitToAdd == true {
            if newlyVisitedAnimal == "Steffi" {
                animalNames = ["Kelly", "Cloud", "Gold", "Harlowe", "Steffi"]
                animalPhotos = [UIImage(named: "photoOfDogKelly"), UIImage(named: "photoOfDogCloud"), UIImage(named: "photoOfDogGold"), UIImage(named: "photoOfDogHarlowe"), UIImage(named: "photoOfDogSteffi")]
                colorCodeColors = [greenLevelColor,yellowLevelColor,puppiesColor,targetColor,greenLevelColor]
                hoursSinceLastVist = [3.2, 1.9, 0.7, 0.2, 0]
            } else if newlyVisitedAnimal == "Kelly" {
                animalNames = ["Steffi", "Cloud", "Gold", "Harlowe", "Kelly"]
                animalPhotos = [UIImage(named: "photoOfDogSteffi"), UIImage(named: "photoOfDogCloud"), UIImage(named: "photoOfDogGold"), UIImage(named: "photoOfDogHarlowe"), UIImage(named: "photoOfDogKelly")]
                colorCodeColors = [greenLevelColor,yellowLevelColor,puppiesColor,targetColor,greenLevelColor]
                hoursSinceLastVist = [3.6, 1.9, 0.7, 0.2, 0]
            } else if newlyVisitedAnimal == "Cloud" {
                animalNames = ["Steffi", "Kelly", "Gold", "Harlowe", "Cloud"]
                animalPhotos = [UIImage(named: "photoOfDogSteffi"), UIImage(named: "photoOfDogKelly"), UIImage(named: "photoOfDogGold"), UIImage(named: "photoOfDogHarlowe"), UIImage(named: "photoOfDogCloud")]
                colorCodeColors = [greenLevelColor,greenLevelColor,puppiesColor,targetColor,yellowLevelColor]
                hoursSinceLastVist = [3.6, 3.2, 0.7, 0.2, 0]
            } else if newlyVisitedAnimal == "Gold" {
                animalNames = ["Steffi", "Kelly", "Cloud", "Harlowe", "Gold"]
                animalPhotos = [UIImage(named: "photoOfDogSteffi"), UIImage(named: "photoOfDogKelly"), UIImage(named: "photoOfDogCloud"), UIImage(named: "photoOfDogHarlowe"), UIImage(named: "photoOfDogGold")]
                colorCodeColors = [greenLevelColor,greenLevelColor,yellowLevelColor,targetColor,puppiesColor]
                hoursSinceLastVist = [3.6, 3.2, 1.9, 0.2, 0]
            } else if newlyVisitedAnimal == "Harlowe" {
                animalNames = ["Steffi", "Kelly", "Cloud", "Gold", "Harlowe"]
                animalPhotos = [UIImage(named: "photoOfDogSteffi"), UIImage(named: "photoOfDogKelly"), UIImage(named: "photoOfDogCloud"), UIImage(named: "photoOfDogGold"), UIImage(named: "photoOfDogHarlowe")]
                colorCodeColors = [greenLevelColor,greenLevelColor,yellowLevelColor,puppiesColor,targetColor]
                hoursSinceLastVist = [3.6, 3.2, 1.9, 0.7, 0]
            }
        }
        
        mainlistTableView.delegate = self
        mainlistTableView.dataSource = self
        
        // details came from tutorial - don't understand. must be in view did load to maintain timer.
        let aSelector : Selector = "updateTime"
        mainShiftTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        endShiftButtonView.layer.cornerRadius = 19
    }
    
    // calculates start time to be 00:00 and formats timer
    func updateTime() {
        shiftTimer.text = Shift.formattedElapsedTime()
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
    
    @IBAction func onFilterButton(sender: AnyObject) {
        performSegueWithIdentifier("toFilterList", sender: self)
        
    }
    
}
