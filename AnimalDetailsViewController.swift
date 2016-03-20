//
//  AnimalDetailsViewController.swift
//  SPCAapp
//
//  Created by Yinan Motiv on 3/14/16.
//  Copyright © 2016 AliciaAndYinan. All rights reserved.
//

import UIKit

class AnimalDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var animalName: String!
    var animalPhoto: UIImage!
    
    var visitTitles = ["Walk", "In-Room Socialization", "Walk", "Walk", "In-Room Socialization"]
    var durationsAndStartTimes = ["20 min from 5:00 PM", "20 min from 5:00 PM", "20 min from 5:00 PM", "20 min from 5:00 PM", "20 min from 5:00 PM"]
    var volunteerInitials = ["initial: AB", "initial: AB", "initial: AB", "initial: AB", "initial: AB"]
    var behaviorNotesContents = ["placehoder behavior notes content", "placehoder behavior notes content", "placehoder behavior notes content", "placehoder behavior notes content", "placehoder behavior notes content"]
    var symptomNotesContents = ["placehoder symptom notes contnent", "placehoder symptom notes contnent", "placehoder symptom notes contnent", "placehoder symptom notes contnent", "placehoder symptom notes contnent"]
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var visitsTableView: UITableView!
    @IBOutlet weak var photoContainerView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitsTableView.delegate = self
        visitsTableView.dataSource = self
        
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
