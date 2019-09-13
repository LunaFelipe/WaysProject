//
//  TrocaTableViewController.swift
//  Projeto Ways
//
//  Created by Felipe Luna Tersi on 08/08/19.
//  Copyright © 2019 Felipe Luna Tersi. All rights reserved.
//

import UIKit

struct Customization {
    var title: String
    var time: String
    var costs: String
    var photo: UIImage
    var description: String
}

class CustomController: UITableViewController {
    
    var customList:[Customization] = []
    
    func addCustomizacao(custom: Customization)  {
        customList.append(custom)
        
        CustomPublication.shared.publicationCustomArray.append(custom)
        //        print("Trocas \(lista)")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customizacaoCell") as! CustomCell
        
        let custom = customList[indexPath.row]
        
        cell.customizationLabel.text = custom.title
        cell.timeLabel.text = custom.time
        cell.priceLabel.text = custom.costs
        cell.customizationImage.image = custom.photo
        
        return cell
    }
    
    @IBAction func backToCustomizacoes(_ segue: UIStoryboardSegue) {
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let custom = customList[indexPath.row]
        
        performSegue(withIdentifier: "customDetailView", sender: custom)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "novaCustomizacao" {
            if let customVC = segue.destination as? AddCustom {
                customVC.customizacaoScreen = self
            }
        } else if segue.identifier == "customDetailView" {
            if let detailVC = segue.destination as? CustomDetail {
                guard let custom = sender as? Customization else
                {
                    return
                }
                
                detailVC.custom = custom
                
            }
        }
    }
}
