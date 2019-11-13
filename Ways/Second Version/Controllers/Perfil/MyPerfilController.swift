//
//  MyPerfilController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 16/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit
import Firebase

class MyPerfilController: UITableViewController {
    
    var name: String?
    var type: String?
    
    private let userID = (Auth.auth().currentUser?.uid)!
    var yourArray = [[String: Any]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProducts()
        fetchUserInfos()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func fetchUserInfos(){
        Database.database().reference().child("User-Info").child(self.userID).observe(.value, with: { (snapshot) in
            
            let userDict = snapshot.value as! [String: Any]
            
            self.name = userDict["name"] as? String
            self.type = userDict["profileType"] as? String
            
        }, withCancel: nil)
    }
    
    //get user products from database and store them into ArrayControl.shared.userProducts
    func fetchProducts(){
        Database.database().reference().child("User").child(userID).child("produtos").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: String]{
                let item = ItemObject()
                item.categorie = dictionary["categorie"]
                item.condition = dictionary["condition"]
                item.descript = dictionary["descript"]
                item.exchange = dictionary["exchange"]
                item.imageUrl = dictionary["imageUrl"]
                item.price = dictionary["price"]
                item.title = dictionary["title"]
                               
               if let productImageUrl = item.imageUrl{
                   let pathReference = Storage.storage().reference(forURL: productImageUrl)
                   pathReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                         if let error = error {
                           print(error)
                           return
                         } else {
                              // Data for "images/island.jpg" is returned
                              item.image = UIImage(data: data!)
                              ArrayControl.shared.userProducts.append(item)
                              
                              DispatchQueue.main.async {
                                  self.tableView.reloadData()
                              }
                         }
                   }
                }
                
            }
        }, withCancel: nil)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrayControl.shared.userProducts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "perfilItemCell") as! PerfilItemCell
        
        let item = ArrayControl.shared.userProducts[indexPath.row]
        cell.title.text = item.title
        cell.price.text = "R$ \(item.price!)"
        cell.condition.text = item.condition
        cell.photo.image = item.image
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "perfilCell") as? PerfilCell
        
        cell?.name.text = self.name
        cell?.type.text = self.type
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 105
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 136
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let exchangePub = ArrayControl.shared.PerfilItemArray[indexPath.row]
        
        performSegue(withIdentifier: "perfilItemSegue", sender: exchangePub)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "perfilItemSegue" {
            if let detailVC = segue.destination as? PerfilItemController {
                guard let item = sender as? Item else
                {
                    return
                }
                
                detailVC.item = item

            }
        }
    }
    

}
