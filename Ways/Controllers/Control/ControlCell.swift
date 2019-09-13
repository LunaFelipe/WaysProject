//
//  ControlCell.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 09/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var reservedLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
