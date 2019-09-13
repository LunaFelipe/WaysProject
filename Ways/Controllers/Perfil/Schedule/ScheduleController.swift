//
//  ScheduleController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 12/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class ScheduleController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        super.viewDidLoad()
        
        self.tableView.rowHeight = 136;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedSegment == 1 {
            return ConfirmedEvent.shared.confirmedEventArray.count
        } else {
            return InterestEvent.shared.interestEventArray.count
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if selectedSegment == 1,
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "eventConfirmedCell") as? EventConfirmedCell {
            
            let confirmEvent = ConfirmedEvent.shared.confirmedEventArray[indexPath.row]
            
            cell1.title.text = confirmEvent.title
            cell1.date.text = confirmEvent.date
            cell1.local.text = confirmEvent.local
            cell1.photo.image = confirmEvent.photo
            
            return cell1
            
        } else if
            
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "eventInterestCell") as? EventInterestCell {
            
            let interestEvent = InterestEvent.shared.interestEventArray[indexPath.row]
            
            cell2.title.text = interestEvent.title
            cell2.date.text = interestEvent.date
            cell2.local.text = interestEvent.local
            cell2.photo.image = interestEvent.photo
            
            return cell2
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedSegment == 1 {
            
            let favoriteExchange = ConfirmedEvent.shared.confirmedEventArray[indexPath.row]
            
            performSegue(withIdentifier: "confirmedEvent", sender: favoriteExchange)
            
        } else {
            
            let favoriteCustom = InterestEvent.shared.interestEventArray[indexPath.row]
            
            performSegue(withIdentifier: "interestEvent", sender: favoriteCustom)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "confirmedEvent" {
            if let detailVC = segue.destination as? ConfirmedEventController {
                guard let event = sender as? Event else
                {
                    return
                }
                
                detailVC.event = event
                
            }
        } else if segue.identifier == "interestEvent" {
            if let detailVC = segue.destination as? InterestEventController {
                guard let event = sender as? Event else
                {
                    return
                }
                
                detailVC.event = event
                
            }
        }
    }

}
