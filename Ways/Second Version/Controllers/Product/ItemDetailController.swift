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
    var isPerfilHidden = false
    
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
            self.item.isFavorite = true
//            print(ProductsController.shared.itensList)
            if ArrayControl.shared.itensList.contains(self.item){
                if let index = ArrayControl.shared.itensList.firstIndex(of: self.item){
                    ArrayControl.shared.itensList[index].isFavorite = true
                }
            }
            
            if ArrayControl.shared.sellerItemArray.contains(self.item){
                if let index = ArrayControl.shared.sellerItemArray.firstIndex(of: self.item){
                    ArrayControl.shared.sellerItemArray[index].isFavorite = true
                }
            }
            favorite.image = UIImage (named: "favorito")
            ArrayControl.shared.favoriteArray.append(self.item)
        } else {
            likePressed = false
            self.item.isFavorite = false
            favorite.image = UIImage (named: "heart")
            
            if ArrayControl.shared.itensList.contains(self.item){
                if let index = ArrayControl.shared.itensList.firstIndex(of: self.item){
                    ArrayControl.shared.itensList[index].isFavorite = false
                }
            }
            
            if ArrayControl.shared.sellerItemArray.contains(self.item){
                if let index = ArrayControl.shared.sellerItemArray.firstIndex(of: self.item){
                    ArrayControl.shared.sellerItemArray[index].isFavorite = false
                }
            }
            
            while ArrayControl.shared.favoriteArray.contains(self.item) {
                if let index = ArrayControl.shared.favoriteArray.firstIndex(of: self.item){
                    ArrayControl.shared.favoriteArray.remove(at: index)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 200
        case 1:
            return 160
        case 2:
            return 144
        case 3:
            return 53
        case 4:
            if isPerfilHidden == true  {
                return 0
            } else {
                return 105
            }
        default:
            return 0
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        titleItem.text = self.item.title
        price.text = "R$ \(self.item.price)"
        condition.text = self.item.condition
        photo.image = self.item.photo
        exchange.text = self.item.exchange
        descriptionItem.text = self.item.description
        
        if let index = ArrayControl.shared.itensList.firstIndex(of: self.item) {
            if ArrayControl.shared.itensList[index].isFavorite == true {
                likePressed = true
                favorite.image = UIImage (named: "favorito")
            } else {
                likePressed = false
                favorite.image = UIImage (named: "heart")
            }
        }
        self.view.setNeedsLayout()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}
