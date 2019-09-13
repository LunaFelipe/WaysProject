//
//  CustomFavoriteDetail.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 12/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class CustomFavoriteDetail: UIViewController {
    
    var custom: Customization!

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var titleFav: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var costs: UILabel!
    @IBOutlet weak var descriptionFav: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let oCustom = self.custom {
            titleFav.text = oCustom.title
            costs.text = oCustom.costs
            time.text = oCustom.time
            photo.image = oCustom.photo
            descriptionFav.text = oCustom.description
        }
        // Do any additional setup after loading the view.
    }

}
