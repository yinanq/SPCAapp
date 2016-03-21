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
    
    var timer = NSTimer()
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
        
        endShiftButtonView.layer.cornerRadius = 19
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let aSelector : Selector = "updateTime"
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // function to format the timer
    func updateTime() {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime: NSTimeInterval = currentTime - startTime
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        shiftTimer.text = "\(strMinutes):\(strSeconds)"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // remove the shadow line at bottom of navbar
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = UIImage();
    }
    
    func updateCounter() {
        shiftTimer.text = String(format: "%02d", Int(shiftCounter++))
    }
    
    // function for End Shift Button
    @IBAction func onEndShift(sender: UIButton) {
        timer.invalidate()
        shiftCounter = 0
        shiftTimer.text = String(shiftCounter)
        performSegueWithIdentifier("endShift", sender: self)
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
