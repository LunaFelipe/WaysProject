//
//  ProductsController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 15/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

struct Item {
    var title: String
    var price: String
    var condition: String
    var categorie: String
    var description: String
    var photo: UIImage
    var exchange: String
    var isFavorite: Bool
    var photo2: UIImage
}

class ProductsController: UITableViewController, UISearchBarDelegate {
    
    func addItem(item: Item)  {
        
        ArrayControl.shared.itensList.append(item)
        ArrayControl.shared.sellerItemArray.append(item)
        ArrayControl.shared.PerfilItemArray.append(item)
    
        //Adicionando na lista de publicaçõe
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setUpSearchController()
    }
    
    func createSearchBar() {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Procure por nomes de roupas"
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrayControl.shared.itensList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productItemCell") as! ProductItemCell
        
        let item = ArrayControl.shared.itensList[indexPath.row]
        
        cell.title.text = item.title
        cell.price.text = "R$ \(item.price)"
        cell.condition.text = item.condition
        cell.photo.image = item.photo
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = ArrayControl.shared.itensList[indexPath.row]
        
        performSegue(withIdentifier: "itemDetail", sender: item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem" {
            if let trocaVC = segue.destination as? AddItem {
                trocaVC.itensScreen = self
            }
        } else if segue.identifier == "itemDetail" {
            if let detailVC = segue.destination as? ItemDetailController {
                guard let item = sender as? Item else
                {
                    return
                }
                detailVC.item = item
            }
        } else if segue.identifier == "backToLogin" {
            if segue.destination is LoginViewController {
                
            }
        }
    }
    
    @IBAction func backToItens(_ segue: UIStoryboardSegue) {
        
    }

}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.title == rhs.title &&
                lhs.price == rhs.price &&
                lhs.condition == rhs.condition &&
                lhs.description == rhs.description &&
                lhs.photo == rhs.photo &&
                lhs.photo2 == rhs.photo2 &&
                lhs.exchange == rhs.exchange 
//                lhs.isFavorite == rhs.isFavorite
    }
}

