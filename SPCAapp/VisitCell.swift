//
//  VisitCell.swift
//  SPCAapp
//
//  Created by Yinan Motiv on 3/20/16.
//  Copyright © 2016 AliciaAndYinan. All rights reserved.
//

import UIKit

class VisitCell: UITableViewCell {

    @IBOutlet weak var visitTitle: UILabel!
    @IBOutlet weak var durationAndStartTime: UILabel!
    @IBOutlet weak var volunteerInitial: UILabel!
    @IBOutlet weak var behaviorNotesTitle: UILabel!
    @IBOutlet weak var behaviorNotesContent: UILabel!
    @IBOutlet weak var symptomNotesTitle: UILabel!
    @IBOutlet weak var symptomNotesContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
