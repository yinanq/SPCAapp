//
//  AnimalDetailsViewController.swift
//  SPCAapp
//
//  Created by Yinan Motiv on 3/14/16.
//  Copyright © 2016 AliciaAndYinan. All rights reserved.
//

import UIKit

class AnimalDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // passed data from table view based on which cell is opened
    var animalName: String!
    var animalPhoto: UIImage!
    
    // passed data from new visit
    var newVisitTitle = "newVisitTitle"
    var newVisitDurationAndStartTime = "newVisitDuratinAnd"
    var newBehaviorNotes: String!
    var newSymptomNotes: String!
    
    // local data
    var visitTitles = ["Walk", "Socialization", "Walk", "Walk", "Socialization"]
    var durationsAndStartTimes = ["20 min from 5:00 PM", "20 min from 5:00 PM", "20 min from 5:00 PM", "20 min from 5:00 PM", "20 min from 5:00 PM"]
    var volunteerInitials = ["initial: AB", "initial: CD", "initial: EF", "initial: GH", "initial: IJ"]
    let userInitials = "YQ"
    var behaviorNotesContents = ["Very sweet, takes a minute to warm up but after that she is very affectionate. She loves treats and is a good walker.", "super sweet and very playful, also loves to curl up in your lap and go to sleep", "Very good walker. Was excited to get outside. Walked by a few different dogs of all sizes and was non-reactive. BM and UR on walk.", "A real snuggle bug, she stayed on my lap for the whole visit. I had to move her at one point and she growled at me though.", "Very sweet. Likes scratches and enjoys treats. Great walker, didnt take issue with other dogs at all."]
    var symptomNotesContents = ["N/A", "Sneezed a lot at one point. Didn't seem like any serious problem.", "N/A", "N/A", "N/A"]
    var hasNewVisitToAdd = false
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var visitsTableView: UITableView!
    @IBOutlet weak var photoContainerView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var roomNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add new cell for new visit if any
        if hasNewVisitToAdd == true {
            visitTitles.insert(newVisitTitle, atIndex: 0)
            durationsAndStartTimes.insert(newVisitDurationAndStartTime, atIndex: 0)
            volunteerInitials.insert(userInitials, atIndex: 0)
            behaviorNotesContents.insert(newBehaviorNotes, atIndex: 0)
            symptomNotesContents.insert(newSymptomNotes, atIndex: 0)
        }
        
        visitsTableView.delegate = self
        visitsTableView.dataSource = self
        
        // table view cell dynamic height Tim code
        visitsTableView.rowHeight = UITableViewAutomaticDimension
        visitsTableView.estimatedRowHeight = 140
        
        navItem.title = animalName
        photoImageView.image = animalPhoto
        
        // dark gradient over photo to display light text on photo        
        let photoCoverGradient = CAGradientLayer()
        photoCoverGradient.frame = photoImageView.bounds
        var colors = [CGColor]()
        colors.append(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).CGColor)
        colors.append(UIColor(red: 0, green: 0, blue: 0, alpha: 0).CGColor)
        photoCoverGradient.colors = colors
        photoCoverGradient.startPoint = CGPointMake(0.5, 1)
        photoCoverGradient.endPoint = CGPointMake(0.5, 0.7)
        photoImageView.layer.addSublayer(photoCoverGradient)
//        segmentedControl.apportionsSegmentWidthsByContent = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visitTitles.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("Row: \(indexPath.row)")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("VisitCell") as! VisitCell
        
        cell.visitTitle.text = visitTitles[indexPath.row]
        cell.durationAndStartTime.text = durationsAndStartTimes[indexPath.row]
        cell.volunteerInitial.text = volunteerInitials[indexPath.row]
        cell.behaviorNotesContent.text = behaviorNotesContents[indexPath.row]
        cell.symptomNotesContent.text = symptomNotesContents[indexPath.row]
        
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        print("prepareForSegue from AnimalDetails to DuringVisit")
        
        // Get the new view controller using segue.destinationViewController.
        let destinationViewController = segue.destinationViewController as! DuringVisitViewController
        
        // Pass the selected object to the new view controller.
        destinationViewController.passedVisitTitle = "Walk"
        destinationViewController.passedAnimalPhoto = animalPhoto
        destinationViewController.passedAnimalName = animalName
        destinationViewController.passedRoomNumber = roomNumber.text
    }
    
}
