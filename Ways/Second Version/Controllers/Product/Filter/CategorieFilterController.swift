//
//  CategorieFilterController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 22/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class CategorieFilterController: UITableViewController {

    var sections = ["Vestuario", "Calçados", "Acessórios" ]
    
    var items = [["Camisa", "Camiseta", "Polo", "Jaqueta", "Moletom", "Corta Vento", "Calça", "Bermuda", "Shorts" ], ["Tênis", "Bota", "Sapato", "Chinelo", "Slipe on"  ], ["Mochila", "Bolsa", "Pochete", "Shoulder Bag", "Relógio", "Óculos", "Pulseiras" ]]
    //    var categories:[String] = []
    var selectedCategories:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        categories = ["Bermuda", "Bonés", "Blusa", "Calça", "Camisa", "Camiseta", "Chapéus", "Chinelo", "Moletom", "Polo", "Saia", "Sandalias", "Shorts", "Tênis", "Vestido", "Bolsa", "Mochila", "Pochete", "Meia" ]
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.section][indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
        
        let index = selectedCategories.firstIndex { (deselectedCategory) -> Bool in
            return deselectedCategory == items[indexPath.section][indexPath.row]
        }
        
        if let indexToRemove = index {
            selectedCategories.remove(at: indexToRemove)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.tintColor = #colorLiteral(red: 0.1411764706, green: 0.5411764706, blue: 0.2392156863, alpha: 1)
            cell.accessoryType = .checkmark
        }
        
        selectedCategories.append(items[indexPath.section][indexPath.row])
        
        // self.performSegue(withIdentifier: "returnToMap", sender: name[indexPath.row])
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "returnToFilter" {
            if segue.destination is FilterController {
            }
        }
    }
    
    @IBAction func doneButtom(_ sender: Any) {
        
        performSegue(withIdentifier: "returnToFilter", sender: nil)
    }
    
    
}
