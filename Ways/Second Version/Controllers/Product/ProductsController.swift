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
    
    // FILTER
    var isFilterApplied: Bool = false
    var categorieSelected: [String] = []
    var distanceSelected: Int = 0
    var priceSelected: Int = 0
    
    //Table View informations
    var searchController: UISearchController? = nil
    var filteredItems: [Item] = []
    
    func addItem(item: Item)  {
        
        ArrayControl.shared.itensList.append(item)
        ArrayControl.shared.sellerItemArray.append(item)
        ArrayControl.shared.PerfilItemArray.append(item)
    
        //Adicionando na lista de publicaçõe
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isFilterApplied = false
        setUpSearchController()
    }
    
    fileprivate func setupFilterButtom() {
        searchController?.searchBar.setShowsCancelButton(true, animated: false)
        // Costumize cancel button to a filter button
        for subView1 in (searchController?.searchBar.subviews)! {
            for subView2 in subView1.subviews {
                if subView2.isKind(of: UIButton.self) {
                    let customizedCancelButton: UIButton = subView2 as! UIButton
                    customizedCancelButton.isEnabled = true
                    customizedCancelButton.setTitle("", for: .normal)
                    let image1 = UIImage(named: "filter")
                    customizedCancelButton.setBackgroundImage(image1, for: .normal)
                    customizedCancelButton.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
                }
            }
        }
    }
    
    func setUpSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.delegate = self
        searchController?.searchResultsUpdater = self
        searchController?.obscuresBackgroundDuringPresentation = false
        searchController?.searchBar.placeholder = "Buscar roupa"
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.searchBar.searchBarStyle = .minimal
        searchController?.searchBar.tintColor = #colorLiteral(red: 0.1411764706, green: 0.5411764706, blue: 0.2392156863, alpha: 1)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.searchController = searchController
        }
        setupFilterButtom()
        definesPresentationContext = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Tirar as linhas de adicionar
        let footerView = UIView()
        tableView.tableFooterView = footerView
        
        tableView.reloadData()
        setupFilterButtom()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        searchController?.searchBar.showsCancelButton = false
    }
    
    @objc func filterTapped(_ sender: UIButton) {
        print("Filtrar")
        
        performSegue(withIdentifier: "filterSegue", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() {
            return filteredItems.count
        }
        
        return ArrayControl.shared.itensList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productItemCell") as! ProductItemCell
        let item: Item
        
        if isFiltering() {
            item = filteredItems[indexPath.row]
        } else {
            item = ArrayControl.shared.itensList[indexPath.row]
        }
        
        cell.title.text = item.title
        cell.price.text = "R$ \(item.price)"
        cell.condition.text = item.condition
        cell.photo.image = item.photo
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item: Item
        if isFiltering() {
            item = filteredItems[indexPath.row]
        } else {
            item = ArrayControl.shared.itensList[indexPath.row]
        }
        
        performSegue(withIdentifier: "itemDetail", sender: item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem" {
            if let trocaVC = segue.destination as? AddItemController {
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
    
//    func filterDistanceAndTags() {
//        var haversineResult: Double = 0
//        self.mapView.removeAnnotations(markets)
//        for market in markets {
//            haversineResult = haversineDinstance(la1: locationManager.location!.coordinate.latitude,
//                                                 lo1: locationManager.location!.coordinate.longitude,
//                                                 la2: market.coordinate.latitude,
//                                                 lo2: market.coordinate.longitude)
//            if Int(haversineResult) < distanceSelected {
//                if Set(market.category).isSuperset(of: tagsSelected) {
//                    self.mapView.addAnnotation(market)
//                }
//            }
//        }
//    }
    
    @IBAction func filterPress(_ segue: UIStoryboardSegue) {
            
            if let filter = segue.source as? FilterController {
                self.isFilterApplied = filter.isFilterApplied
                self.distanceSelected = filter.distanceSelected
                self.categorieSelected = filter.selectedCategories
                self.priceSelected = filter.priceSelected
                
//                filterDistanceAndTags()
            }
    }
}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.title == rhs.title &&
            lhs.price == rhs.price &&
            lhs.condition == rhs.condition &&
            lhs.description == rhs.description &&
            lhs.photo == rhs.photo &&
            lhs.photo2 == rhs.photo &&
            lhs.exchange == rhs.exchange
        //                lhs.isFavorite == rhs.isFavorite
    }
}

//Search bar delegate, search results updating and search bar code in general
extension ProductsController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        
        //         Uncover the plus item when search bar is active
        //        if !searchController.isActive {
        //            searchController.searchBar.setShowsCancelButton(false, animated: false)
        //            // Add the plus button again
        //            let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        //            rightBarButton.tintColor = #colorLiteral(red: 0.1411764706, green: 0.5411764706, blue: 0.2392156863, alpha: 1)
        //            navigationItem.setRightBarButton(rightBarButton, animated: true)
        //        }
    }
    
    @objc func addTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addItem", sender: nil)
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        //      Add the cancel button
        searchController.searchBar.setShowsCancelButton(true, animated: false)
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.removeLayerAnimationsRecursively()
    }
    
    @IBAction func dismissSearch(_ sender: UITapGestureRecognizer) {
        searchController?.searchBar.endEditing(true)
        
        if searchController?.searchBar.text?.isEmpty ?? false {
            searchController?.isActive = false
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController?.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredItems = ArrayControl.shared.itensList.filter({(item: Item) -> Bool in return item.title.lowercased().contains(searchText.lowercased())})
        
        //        //Uncomment if you want to filter by categorie too
        //        let filterByCategorie: [Item] = items.filter({(item: Item) -> Bool in return item.categorie.lowercased().contains(filter.lowercased())})
        //
        //        for item in filterByCategorie {
        //            if !filteredItems.contains(item) {
        //                filteredItems.append(item)
        //            }
        //        }
        
        //Alphabetic order
        filteredItems.sort { $0.title < $1.title }
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController?.isActive ?? false && !searchBarIsEmpty()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancelar")
    }
    
}

extension UIView {
    
    func removeLayerAnimationsRecursively() {
        layer.removeAllAnimations()
        subviews.forEach { $0.removeLayerAnimationsRecursively() }
    }
}

