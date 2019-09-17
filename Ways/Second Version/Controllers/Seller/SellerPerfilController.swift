//
//  PerfilDetailController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 16/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class SellerPerfilController: UITableViewController {

//    static let shared = SellerPerfilController()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
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
