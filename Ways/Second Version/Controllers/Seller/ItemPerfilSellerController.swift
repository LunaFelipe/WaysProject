//
//  ItemPerfilSellerController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 16/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class ItemPerfilSellerController: UITableViewController {
    
    var item: Item!

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var titleitem: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var exchange: UILabel!
    @IBOutlet weak var descriptionItem: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let oItem = self.item {
            photo.image = oItem.photo
            titleitem.text = oItem.title
            price.text = oItem.price
            condition.text = oItem.condition
            exchange.text = oItem.exchange
            descriptionItem.text = oItem.description
        }
    }

}
