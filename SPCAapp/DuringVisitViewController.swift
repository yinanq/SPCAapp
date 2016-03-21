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
    
    var pressAndHolding = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        endVisitView.layer.cornerRadius =  endVisitView.bounds.width/2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didLongPressEndVisitView(sender: UILongPressGestureRecognizer) {
        NSLog("long press")
        NSLog("pressAndHolding is \(pressAndHolding)")
        if sender.state == UIGestureRecognizerState.Began {
            NSLog("long press state Began")
            pressAndHolding = true
            NSLog("pressAndHolding is \(pressAndHolding)")
        } else if sender.state == UIGestureRecognizerState.Ended {
            NSLog("long press state Ended")
            pressAndHolding = false
            NSLog("pressAndHolding is \(pressAndHolding)")
        } else {
            NSLog("long press state else")
        }
    }
    
    @IBAction func didTouchUpInsideEndVisitButton(sender: AnyObject) {
        growEndVisitView()
    }

    // MARK: - My Functions
    
    func growEndVisitView() {
        endVisitView.bounds.size = CGSize(width: endVisitView.bounds.width+1, height: endVisitView.bounds.height+1)
        endVisitView.layer.cornerRadius = endVisitView.bounds.width/2
    }
    
    func growEndVisitViewTo(diameter: CGFloat) {
        endVisitView.bounds.size = CGSize(width: diameter, height: diameter)
        endVisitView.layer.cornerRadius = diameter/2
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
