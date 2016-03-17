//
//  AnimalDetailsViewController.swift
//  SPCAapp
//
//  Created by Yinan Motiv on 3/14/16.
//  Copyright © 2016 AliciaAndYinan. All rights reserved.
//

import UIKit

class AnimalDetailsViewController: UIViewController {

    var animalName: String!
    var animalPhoto: UIImage!
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    @IBOutlet weak var photoContainerView: UIView!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
