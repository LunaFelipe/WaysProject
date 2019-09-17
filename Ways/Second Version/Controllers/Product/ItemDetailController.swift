//
//  ItemDetailController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 16/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class ItemDetailController: UITableViewController {
    
    var item: Item!

    var likePressed: Bool = false
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var titleItem: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var exchange: UILabel!
    @IBOutlet weak var descriptionItem: UITextView!
   
    @IBOutlet weak var favorite: UIBarButtonItem!
    
    @IBAction func favoriteButtom(_ sender: UIBarButtonItem) {
        
        if likePressed == false {
            likePressed = true
            favorite.image = UIImage (named: "favorito")
            FavoriteList.shared.favoriteArray.append(self.item)
            return
        } else {
            likePressed = false
            favorite.image = UIImage (named: "heart")
            while FavoriteList.shared.favoriteArray.contains(self.item) {
                if let index = FavoriteList.shared.favoriteArray.firstIndex(of: self.item){
                    FavoriteList.shared.favoriteArray.remove(at: index)
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let oItem = self.item {
            titleItem.text = oItem.title
            price.text = "R$ \(oItem.price)"
            condition.text = oItem.condition
            photo.image = oItem.photo
            exchange.text = oItem.exchange
            descriptionItem.text = oItem.description
        }
        // Do any additional setup after loading the view.
    }
}
