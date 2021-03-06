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
    @IBOutlet weak var endVisitView: UIView!
    @IBOutlet weak var endVisitLabel: UILabel!
    @IBOutlet weak var visitDurationLabel: UILabel!
    
    @IBOutlet weak var endVisitWidth: NSLayoutConstraint!
    @IBOutlet weak var endVisitHeight: NSLayoutConstraint!
    @IBOutlet weak var endVisitDistanceToBottom: NSLayoutConstraint!
    
    var pressAndHolding = false
    var endVisitViewNormalDiameter: CGFloat!
    var endVisitViewMaxDiameter: CGFloat!
    // used for animation scale
    var endVisitViewScaleTimer: NSTimer!
    
    var visitTimer = NSTimer()
    var startTime = NSTimeInterval()
    var shiftCounter = 0
    
    // data to be passed from AnimalDetailsViewController
    var passedVisitTitle: String!
    var passedAnimalPhoto: UIImage!
    var passedAnimalName: String!
    var passedRoomNumber: String!
    
    // data to be passed to VisitSummaryViewController
    var durationMinutes: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        endVisitView.layer.cornerRadius =  endVisitView.bounds.width/2
        endVisitViewNormalDiameter = endVisitView.bounds.width
        endVisitViewMaxDiameter = 1200
        
        endVisitViewScaleTimer = NSTimer.scheduledTimerWithTimeInterval(0.002, target: self, selector: "scaleEndVisitView", userInfo: nil, repeats: true)

        let aSelector : Selector = "updateTime"
        visitTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
        print("start time: \(startTime)")
        
        // apply data passed from AnimalDetailsViewController
        visitTitle.text = passedVisitTitle
        animalPhoto.image = passedAnimalPhoto
        animalName.text = passedAnimalName
        roomNumber.text = passedRoomNumber
        
        animalPhoto.layer.cornerRadius = animalPhoto.bounds.width/2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime: NSTimeInterval = currentTime - startTime
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        visitDurationLabel.text = "\(strMinutes):\(strSeconds)"
        
        // data to be passed to VisitSummaryViewController
        durationMinutes = "\(strMinutes)"
        NSLog("durationMinuts: \(durationMinutes)")
    }
    
    @IBAction func didLongPressEndVisitView(sender: UILongPressGestureRecognizer) {
        NSLog("long press")
        NSLog("pressAndHolding is \(pressAndHolding)")
        if sender.state == UIGestureRecognizerState.Began {
            NSLog("long press state: Began")
            pressAndHolding = true
            NSLog("pressAndHolding is \(pressAndHolding)")
        } else if sender.state == UIGestureRecognizerState.Ended {
            NSLog("long press state: Ended")
            pressAndHolding = false
            NSLog("pressAndHolding is \(pressAndHolding)")
        } else {
            NSLog("long press state: else")
        }
    }

    // MARK: - Custom Methods
    
    func growEndVisitView() {
        if endVisitView.bounds.width < endVisitViewMaxDiameter {
            
            //use this code if autolayout is off
//            endVisitView.bounds.size = CGSize(width: endVisitView.bounds.width+1, height: endVisitView.bounds.height+1)
            
            //use this code if autolayout is on
            endVisitWidth.constant += 1
            endVisitHeight.constant += 1
            endVisitDistanceToBottom.constant -= 0.5
            
            endVisitView.layer.cornerRadius = endVisitView.bounds.width/2
        }
    }
    
    func shrinkEndVisitView() {
        if endVisitView.bounds.width > endVisitViewNormalDiameter {
            
            //use this code if autolayout is off
//            endVisitView.bounds.size = CGSize(width: endVisitView.bounds.width-2, height: endVisitView.bounds.height-2)
            
            //use this code if autolayout is on
            endVisitWidth.constant -= 1
            endVisitHeight.constant -= 1
            endVisitDistanceToBottom.constant += 0.5
            
            endVisitView.layer.cornerRadius = endVisitView.bounds.width/2
        }
    }
    
    func scaleEndVisitView() {
        if pressAndHolding == true {
            growEndVisitView()
        } else {
            shrinkEndVisitView()
        }
        if endVisitView.bounds.width >= endVisitViewMaxDiameter {
            endVisitViewScaleTimer.invalidate()
            visitTimer.invalidate()
            performSegueWithIdentifier("endVisitSegue", sender: self)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        let destinationViewController = segue.destinationViewController as! VisitSummaryViewController
        
        // Pass the selected object to the new view controller.
        destinationViewController.passedAnimalPhoto = passedAnimalPhoto
        destinationViewController.passedAnimalName = passedAnimalName
        destinationViewController.durationMinutes = durationMinutes
        destinationViewController.passedVisitTitle = passedVisitTitle
    }

}
