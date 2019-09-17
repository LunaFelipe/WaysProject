//
//  InterestEventController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 12/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class InterestEventController: UIViewController {

    var event: Event!
    
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var local: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let oEvent = self.event {
            eventTitle.text = oEvent.title
            date.text = oEvent.date
            local.text = oEvent.local
            photo.image = oEvent.photo
            eventDescription.text = oEvent.description
        }
    }

}
