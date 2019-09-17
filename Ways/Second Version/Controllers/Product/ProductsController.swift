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
}

class ProductsController: UITableViewController, UISearchBarDelegate {
    
    var itensList:[Item] = []
//    var currentItem = [Item]()
    
    func addItem(item: Item)  {
        itensList.append(item)
        
        SellerItem.shared.sellerItemArray.append(item)
        PerfilItem.shared.PerfilItemArray.append(item)
    
        //Adicionando na lista de publicaçõe
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setUpSearchController()
    }
    
//    fileprivate func setUpSearchController() {
//        // Setup the Search Controller
//        if let resultViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchController") as? SearchViewController {
//            searchController = UISearchController(searchResultsController: resultViewController)
//
//            searchDelegate = resultViewController
//
//            searchController?.delegate = self
//            searchController?.searchResultsUpdater = self
//            searchController?.obscuresBackgroundDuringPresentation = false
//            searchController?.searchBar.placeholder = "Buscar feiras"
//            searchController?.hidesNavigationBarDuringPresentation = false
//            searchController?.searchBar.searchBarStyle = .minimal
//            searchController?.searchBar.tintColor = #colorLiteral(red: 0.1411764706, green: 0.5411764706, blue: 0.2392156863, alpha: 1)
//            navigationItem.titleView = searchController?.searchBar
//            definesPresentationContext = true
//
//            resultViewController.selectedMarketDelegate = self
//        }
//    }
    
    func createSearchBar() {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Procure por nomes de roupas"
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
    }
    
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        currentAnimalArray = itensList.filter({ animal -> Bool in
//            switch searchBar.selectedScopeButtonIndex {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itensList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productItemCell") as! ProductItemCell
        
        let item = itensList[indexPath.row]
        
        cell.title.text = item.title
        cell.price.text = "R$ \(item.price)"
        cell.condition.text = item.condition
        cell.photo.image = item.photo
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = itensList[indexPath.row]
        
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
                lhs.exchange == rhs.exchange
    }
}

