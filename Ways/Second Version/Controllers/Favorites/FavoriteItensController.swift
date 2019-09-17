//
//  FavoriteItensController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 16/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class FavoriteItensController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 136
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ArrayControl.shared.favoriteArray.count
  
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell") as! FavoriteCell
        
        let item = ArrayControl.shared.favoriteArray[indexPath.row]
        
        cell.title.text = item.title
        cell.price.text = "R$ \(item.price)"
        cell.condition.text = item.condition
        cell.photo.image = item.photo
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let exchangePub = ArrayControl.shared.favoriteArray[indexPath.row]
        
        performSegue(withIdentifier: "favoriteCell", sender: exchangePub)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoriteCell" {
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            ArrayControl.shared.favoriteArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
}
