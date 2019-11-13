//
//  MyPerfilController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 16/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift

class MyPerfilController: UITableViewController {
    
    var name: String?
    var type: String?
    var count = 0
    var itemSend: ItemObject?
    var itemObject = ItemObject()
    var image: UIImage?
    var image2: UIImage?
    
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
                                                             
                             self.itemObject.categorie = dictionary["categorie"]
                             self.itemObject.condition = dictionary["condition"]
                             self.itemObject.descript = dictionary["descript"]
                             self.itemObject.exchange = dictionary["exchange"]
                             self.itemObject.imageUrl = dictionary["imageUrl"]
                             self.itemObject.price = dictionary["price"]
                             self.itemObject.title = dictionary["title"]
                             
                             // Create a reference to the file you want to download
                             let pathReference = Storage.storage().reference(forURL: self.itemObject.imageUrl!)
                             // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                             pathReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                               if let error = error {
                                 print(error)
                                 return
                               } else {
                                    self.image = UIImage(data: data!)
                                                                    
                                let item = Item(seller: self.userID, title: dictionary["title"]!, price: dictionary["price"]!, condition: dictionary["condition"]!, categorie: dictionary["categorie"]!, description: dictionary["descript"]!, photo: self.image!, exchange: dictionary["exchange"]!, isFavorite: false, photo2: self.image!)

                                    ArrayControl.shared.userProducts.append(item)

                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                    }
                               }
                             }

                         }
                     }, withCancel: nil)
                     
                 
    }

    override func viewWillAppear(_ animated: Bool) {
        self.count = 0
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(ArrayControl.shared.userProducts.count)
        return ArrayControl.shared.userProducts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "perfilItemCell") as! PerfilItemCell
        
        let item = ArrayControl.shared.userProducts[indexPath.row]
        cell.title.text = item.title
        cell.price.text = "R$ \(item.price)"
        cell.condition.text = item.condition
        cell.photo.image = item.photo

        
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
        
        let exchangePub = ArrayControl.shared.userProducts[indexPath.row]

        
        performSegue(withIdentifier: "productPerfil", sender: exchangePub)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productPerfil" {
            if let detailVC = segue.destination as? ItemDetailController {
                guard let item = sender as? Item else
                {
                    return
                }
                print(item.title)
                detailVC.item = item
            }
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        ArrayControl.shared.userProducts = []
            ArrayControl.shared.itensList = []
            let firebaseAuth = Auth.auth()
            do{
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
            KeychainSwift().delete("uid")
        
            Switcher.updateRootVC()
    }
    
}
