//
//  CustomDetail.swift
//  Projeto Ways
//
//  Created by Felipe Luna Tersi on 01/09/19.
//  Copyright © 2019 Felipe Luna Tersi. All rights reserved.
//

import UIKit

class CustomDetail: UIViewController {
    
    var custom: Customization!
    
    var likePressed: Bool = false

    @IBOutlet weak var priceDetail: UILabel!
    @IBOutlet weak var timeDetail: UILabel!
    @IBOutlet weak var customTitleDetail: UILabel!
    @IBOutlet weak var imgDetail: UIImageView!
    @IBOutlet weak var descriptionDetail: UILabel!
    

    @IBAction func favoriteButtom(_ sender: Any) {
        
        if likePressed == false {
            likePressed = true
            CustomFavoriteList.shared.favoriteCustomArray.append(self.custom)
            return
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let oCustom = self.custom {
            customTitleDetail.text = oCustom.title
            priceDetail.text = "R$ \(oCustom.costs)"
            timeDetail.text = oCustom.time
            imgDetail.image = oCustom.photo
            descriptionDetail.text = oCustom.description
        }
        // Do any additional setup after loading the view.
    }
}
