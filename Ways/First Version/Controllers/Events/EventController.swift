//
//  EventosTableViewController.swift
//  Projeto Ways
//
//  Created by Felipe Luna Tersi on 27/08/19.
//  Copyright © 2019 Felipe Luna Tersi. All rights reserved.
//

import UIKit

struct Event {
    var title: String
    var local: String
    var date: String
    var photo: UIImage
    var description: String
}

class EventController: UITableViewController {

    var lista: [Event] = []
    
    func addEvent(event: Event)  {
        lista.append(event)
        
        EventPublication.shared.publicationEventArray.append(event)
        //        print("Trocas \(lista)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lista.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! EventCell
        
        let event = lista[indexPath.row]
        
        cell.eventLabel.text = event.title
        cell.dataLabel.text = event.date
        cell.localLabel.text = event.local
        cell.eventImage.image = event.photo
        
        return cell
    }

    @IBAction func backToEvents(_ segue: UIStoryboardSegue) {
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let event = lista[indexPath.row]
        
        performSegue(withIdentifier: "eventDetailView", sender: event)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "novoEvento" {
            if let eventVC = segue.destination as? AddEvent {
                eventVC.eventScreen = self
            }
        } else if segue.identifier == "eventDetailView" {
            if let detailVC = segue.destination as? EventDetail {
                guard let event = sender as? Event else
                {
                    return
                }
                
                detailVC.event = event
                
            }
        }
    }

}
