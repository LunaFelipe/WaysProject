//
//  AddCategorieController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 16/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class AddCategorieController: UITableViewController {
    
    var categories:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categories = ["Calça", "Camiseta", "Blusa", "Moletom"]
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categorieCell") as! CategorieCell
        
        cell.categorie.text = categories[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "backToAddItem", sender: categories[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToAddItem" {
            if let abastecimentoVC = segue.destination as? AddItem {
                abastecimentoVC.categorieItem = sender as? String
            }
        }
    }
    
}
