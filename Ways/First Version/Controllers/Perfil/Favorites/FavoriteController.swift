//
//  FavoriteController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 11/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class FavoriteController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedSegment = 1

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func switchSegment(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            
            selectedSegment = 1

        } else {
            
            selectedSegment = 2
            
        }
        
        self.tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        
        self.tableView.rowHeight = 136;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedSegment == 1 {
            return ExcFavoriteList.shared.favoriteExcArray.count
        } else {
            return CustomFavoriteList.shared.favoriteCustomArray.count
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if selectedSegment == 1,
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "excFavCell") as? ExchangeFavCell {
            
            let excFav = ExcFavoriteList.shared.favoriteExcArray[indexPath.row]
            
            cell1.title.text = excFav.title
            cell1.condition.text = excFav.condition
            cell1.preference.text = excFav.preference
            cell1.photo.image = excFav.photo
            
            return cell1
            
        } else if
            
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "customFavCell") as? CustomFavCell {
            
            let customFav = CustomFavoriteList.shared.favoriteCustomArray[indexPath.row]
            
            cell2.title.text = customFav.title
            cell2.costs.text = customFav.costs
            cell2.time.text = customFav.time
            cell2.photo.image = customFav.photo
            
            return cell2
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedSegment == 1 {
        
            let favoriteExchange = ExcFavoriteList.shared.favoriteExcArray[indexPath.row]
        
            performSegue(withIdentifier: "favoriteExchange", sender: favoriteExchange)
            
        } else {
        
            let favoriteCustom = CustomFavoriteList.shared.favoriteCustomArray[indexPath.row]
        
            performSegue(withIdentifier: "favoriteCustomization", sender: favoriteCustom)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoriteExchange" {
            if let detailVC = segue.destination as? ExchangeFavoriteDetail {
                guard let troca = sender as? Exchange else
                {
                    return
                }
                
                detailVC.troca = troca
                
            }
        } else if segue.identifier == "favoriteCustomization" {
            if let detailVC = segue.destination as? CustomFavoriteDetail {
                guard let custom = sender as? Customization else
                {
                    return
                }
                
                detailVC.custom = custom
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            ExcFavoriteList.shared.favoriteExcArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
}
