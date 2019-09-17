//
//  EventPubController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 12/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class EventPubController: UIViewController {
    
    var event : Event!
    
    @IBOutlet weak var pubDescription: UILabel!
    @IBOutlet weak var local: UILabel!
    @IBOutlet weak var datePub: UILabel!
    @IBOutlet weak var pubTitle: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let oEvent = self.event {
            pubTitle.text = oEvent.title
            datePub.text = oEvent.date
            local.text = oEvent.local
            photo.image = oEvent.photo
            pubDescription.text = oEvent.description
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
