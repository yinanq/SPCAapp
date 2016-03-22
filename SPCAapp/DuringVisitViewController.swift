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
    @IBOutlet weak var durationTimerLabel: UILabel!
    
    var pressAndHolding = false
    var endVisitViewNormalDiameter: CGFloat!
    var endVisitViewMaxDiameter: CGFloat!
    var endVisitViewScaleTimer: NSTimer!
    var visitDurationTimer: NSTimer!
    let visitDurationFormatter = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        endVisitView.layer.cornerRadius =  endVisitView.bounds.width/2
        endVisitViewNormalDiameter = endVisitView.bounds.width
        endVisitViewMaxDiameter = 950
        
        endVisitViewScaleTimer = NSTimer.scheduledTimerWithTimeInterval(0.002, target: self, selector: "scaleEndVisitView", userInfo: nil, repeats: true)
        
        visitDurationFormatter.dateFormat = "hh:mm:ss"
        updateTime()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            endVisitView.bounds.size = CGSize(width: endVisitView.bounds.width+1, height: endVisitView.bounds.height+1)
            endVisitView.layer.cornerRadius = endVisitView.bounds.width/2
        }
    }
    
    func shrinkEndVisitView() {
        if endVisitView.bounds.width > endVisitViewNormalDiameter {
            endVisitView.bounds.size = CGSize(width: endVisitView.bounds.width-2, height: endVisitView.bounds.height-2)
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
            performSegueWithIdentifier("endVisitSegue", sender: self)
        }
    }
    
    func updateTime() {
        durationTimerLabel.text = visitDurationFormatter.stringFromDate(NSDate())
    }
    
//    func endVisit() {
//        if endVisitView.bounds.width >= endVisitViewMaxDiameter {
//            performSegueWithIdentifier("endVisitSegue", sender: self)
//        }
//    }
//    
//    func growEndVisitViewTo(diameter: CGFloat) {
//        endVisitView.bounds.size = CGSize(width: diameter, height: diameter)
//        endVisitView.layer.cornerRadius = diameter/2
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
