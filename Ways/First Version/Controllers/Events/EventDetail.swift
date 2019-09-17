//
//  EventDetail.swift
//  Projeto Ways
//
//  Created by Felipe Luna Tersi on 01/09/19.
//  Copyright © 2019 Felipe Luna Tersi. All rights reserved.
//

import UIKit

class EventDetail: UIViewController {
    
    var event : Event!
    var confirmedPressed: Bool = false
    var interestPressed: Bool = false

    @IBOutlet weak var imgDetail: UIImageView!
    @IBOutlet weak var eventTitleDetail: UILabel!
    @IBOutlet weak var dataDetail: UILabel!
    @IBOutlet weak var localDetail: UILabel!
    @IBOutlet weak var descriptionDetail: UILabel!
    
    @IBAction func confirmButtom(_ sender: Any) {
        
        if confirmedPressed == false {
            confirmedPressed = true
            ConfirmedEvent.shared.confirmedEventArray.append(self.event)
            return
        }
    }
    
    @IBAction func interestButtom(_ sender: Any) {
        
        if interestPressed == false {
            interestPressed = true
            InterestEvent.shared.interestEventArray.append(self.event)
            return
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let oEvent = self.event {
            eventTitleDetail.text = oEvent.title
            dataDetail.text = oEvent.date
            localDetail.text = oEvent.local
            imgDetail.image = oEvent.photo
            descriptionDetail.text = oEvent.description
            
        }
    }
}
