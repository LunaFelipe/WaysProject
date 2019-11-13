//
//  AddCategorieController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 16/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class AddCategorieController: UITableViewController {
    
    var sections = ["Vestuario", "Calçados", "Acessórios" ]
    var items = [["Camisa", "Camiseta", "Polo", "Jaqueta", "Moletom", "Corta Vento", "Calça", "Bermuda", "Shorts" ], ["Tênis", "Bota", "Sapato", "Chinelo", "Slipe on"  ], ["Mochila", "Bolsa", "Pochete", "Shoulder Bag", "Relógio", "Óculos", "Pulseiras" ]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categorieCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.section][indexPath.row]
        return cell
    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return categories.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "categorieCell") as! CategorieCell
//
//        cell.categorie.text = categories[indexPath.row]
//        return cell
//    }
//
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.performSegue(withIdentifier: "backToAddItem", sender: items[indexPath.section][indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToAddItem" {
            if let abastecimentoVC = segue.destination as? AddItemController {
                abastecimentoVC.categorieItem = sender as? String
            }
        }
    }
    
}
