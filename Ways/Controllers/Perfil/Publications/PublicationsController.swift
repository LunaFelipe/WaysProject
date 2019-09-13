//
//  PublicationsController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 12/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class PublicationsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedSegment = 1
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func switchSegment(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            
            selectedSegment = 1
            
        } else if sender.selectedSegmentIndex == 1 {
            
            selectedSegment = 2
            
        } else {
            
            selectedSegment = 3
        }
        
        self.tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      self.tableView.rowHeight = 136;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedSegment == 1 {
            return ExchangePublication.shared.publicationExcArray.count
        } else if selectedSegment == 2 {
            return CustomPublication.shared.publicationCustomArray.count
        } else {
            return EventPublication.shared.publicationEventArray.count
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if selectedSegment == 1,
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "excPubCell") as? ExchangePubCell {
            
            let excPub = ExchangePublication.shared.publicationExcArray[indexPath.row]
            
            cell1.title.text = excPub.title
            cell1.condition.text = excPub.condition
            cell1.preference.text = excPub.preference
            cell1.photo.image = excPub.photo

            return cell1
            
        } else if selectedSegment == 2,
            
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "customPubCell") as? CustomPubCell {
            
            let customPub = CustomPublication.shared.publicationCustomArray[indexPath.row]
            
            cell2.title.text = customPub.title
            cell2.costs.text = customPub.costs
            cell2.time.text = customPub.time
            cell2.photo.image = customPub.photo
            
            return cell2
            
        } else if
        
        let cell3 = tableView.dequeueReusableCell(withIdentifier: "eventPubCell") as? EventPubCell {
            
            let eventPub = EventPublication.shared.publicationEventArray[indexPath.row]
            
            cell3.title.text = eventPub.title
            cell3.date.text = eventPub.date
            cell3.local.text = eventPub.local
            cell3.photo.image = eventPub.photo
            
            return cell3
        
        }
        
         return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedSegment == 1 {
            
            let exchangePub = ExchangePublication.shared.publicationExcArray[indexPath.row]
            
            performSegue(withIdentifier: "excPub", sender: exchangePub)
            
        } else if selectedSegment == 2 {
            
            let customPub = CustomPublication.shared.publicationCustomArray[indexPath.row]
            
            performSegue(withIdentifier: "customPub", sender: customPub)
            
        } else if selectedSegment == 3 {
        
            let eventPub = EventPublication.shared.publicationEventArray[indexPath.row]
        
            performSegue(withIdentifier: "eventPub", sender: eventPub)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "excPub" {
            if let detailVC = segue.destination as? ExcPubController {
                guard let troca = sender as? Exchange else
                {
                    return
                }
                
                detailVC.troca = troca
                
            }
        } else if segue.identifier == "customPub" {
            if let detailVC = segue.destination as? CustomPubController {
                guard let custom = sender as? Customization else
                {
                    return
                }
                
                detailVC.custom = custom
                
            }
        } else if segue.identifier == "eventPub" {
            if let detailVC = segue.destination as? EventPubController {
                guard let event = sender as? Event else
                {
                    return
                }
                
                detailVC.event = event
                
            }
        }
    }
    
}
