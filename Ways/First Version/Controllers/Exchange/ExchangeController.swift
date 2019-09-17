//
//  TrocaTableViewController.swift
//  Projeto Ways
//
//  Created by Felipe Luna Tersi on 08/08/19.
//  Copyright © 2019 Felipe Luna Tersi. All rights reserved.
//

import UIKit

struct Exchange {
    var title: String
    var condition: String
    var preference: String
    var photo: UIImage
    var description: String
}

class ExchangeController: UITableViewController {

    var exchangeList:[Exchange] = []
    
    
    func addTroca(troca: Exchange)  {
        exchangeList.append(troca)
        
        //Adicionando na lista de publicações
        ExchangePublication.shared.publicationExcArray.append(troca)
                print("Trocas \(exchangeList)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangeList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "trocaCell") as! ExchangeCell

        let troca = exchangeList[indexPath.row]
        
        cell.clotheLabel.text = troca.title
        cell.conditionLabel.text = troca.condition
        cell.preferenceLabel.text = troca.preference
        cell.clotheImage.image = troca.photo
        
        return cell
    }
    
    @IBAction func backToTrocas(_ segue: UIStoryboardSegue) {
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let troca = exchangeList[indexPath.row]
        
        performSegue(withIdentifier: "detailView", sender: troca)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "novaTroca" {
            if let trocaVC = segue.destination as? AddExchange {
                trocaVC.trocaScreen = self
            }
        } else if segue.identifier == "detailView" {
            if let detailVC = segue.destination as? ExchangeDetail {
                guard let troca = sender as? Exchange else
                {
                    return
                }
                
                detailVC.troca = troca
                
            }
        }
    }
}
