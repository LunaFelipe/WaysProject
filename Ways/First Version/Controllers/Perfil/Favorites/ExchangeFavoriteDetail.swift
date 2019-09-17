//
//  ExchangeFavoriteDetail.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 12/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class ExchangeFavoriteDetail: UIViewController {
    
    @IBOutlet weak var photo: UIImageView!

    @IBOutlet weak var titleFav: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var preference: UILabel!
    @IBOutlet weak var descriptionFav: UILabel!
    
    var troca: Exchange!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let oTroca = self.troca {
            titleFav.text = oTroca.title
            condition.text = oTroca.condition
            preference.text = oTroca.preference
            photo.image = oTroca.photo
            descriptionFav.text = oTroca.description
        }
    }
}
