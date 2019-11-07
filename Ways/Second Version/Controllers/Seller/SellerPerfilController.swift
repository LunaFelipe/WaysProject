//
//  PerfilDetailController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 16/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit
import Firebase

class SellerPerfilController: UITableViewController {

    var sellerID: String?
    var sellerName: String?
    var sellerType: String?
    var itemObject = ItemObject()
    var image: UIImage?

    
    override func viewDidLoad() {
        ArrayControl.shared.sellerItemArray.removeAll()
        fetchSellerProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func fetchSellerProducts(){
        Database.database().reference().child("User").child(self.sellerID!).child("produtos").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: String]{
                
               if let productImageUrl = dictionary["imageUrl"]{
                   let pathReference = Storage.storage().reference(forURL: productImageUrl)
                   pathReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                         if let error = error {
                           print(error)
                           return
                         } else {
                            let item = Item(seller: self.sellerID!,
                                            title: dictionary["title"]!,
                                            price: dictionary["price"]!,
                                            condition: dictionary["condition"]!,
                                            categorie: dictionary["categorie"]!,
                                            description: dictionary["descript"]!,
                                            photo: UIImage(data: data!)!,
                                            exchange: dictionary["exchange"]!,
                                            isFavorite: false,
                                            photo2: UIImage(data: data!)!)
                              
                              ArrayControl.shared.sellerItemArray.append(item)
                              
                              DispatchQueue.main.async {
                                  self.tableView.reloadData()
                              }
                         }
                   }
                }
                
            }
        }, withCancel: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ArrayControl.shared.sellerItemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sellerItemCell") as! SellerItemCell
        
        let item = ArrayControl.shared.sellerItemArray[indexPath.row]
        
        cell.title.text = item.title
        cell.price.text = "R$ \(item.price)"
        cell.condition.text = item.condition
        cell.photo.image = item.photo
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "sellerPerfilCell") as? SellerPerfilCell
            cell?.name.text = self.sellerName
            cell?.type.text = self.sellerType
        
            return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
            return 105

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return 136
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let exchangePub = ArrayControl.shared.sellerItemArray[indexPath.row]
            
            performSegue(withIdentifier: "ItemPerfilSellerCell", sender: exchangePub)
            
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemPerfilSellerCell" {
            if let detailVC = segue.destination as? ItemDetailController {
                guard let troca = sender as? Item else
                {
                    return
                }
                detailVC.isPerfilHidden = true
                detailVC.item = troca
            }
        }
    }
    
}
