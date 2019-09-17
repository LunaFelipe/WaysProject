//
//  ControlController.swift
//  
//
//  Created by Felipe Luna Tersi on 09/09/19.
//

import UIKit

struct Goals {
    var goal: String
    var value: String
    var lack: String
}

struct Shopping {
    var store: String
    var date: String
    var value: String
}

class ControlController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var goalList:[Goals] = []
    var shoppingList:[Shopping] = []
    
    func addGoal(goal: Goals)  {
        goalList.append(goal)
        //        print("Trocas \(lista)")
    }
    
    func addShopping(shopp: Shopping)  {
        shoppingList.append(shopp)
        //        print("Trocas \(lista)")
    }
    
    var selectedSegment = 1
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }

    
    @IBAction func switchSegment(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            
            selectedSegment = 1
            
        } else {
            
            selectedSegment = 2
        
        }
        
        self.tableView.reloadData()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedSegment == 1 {
            return goalList.count
        } else {
            return shoppingList.count
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension

    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        print("Cell for row")
        if selectedSegment == 1,
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell {
            
            let goal = goalList[indexPath.row]
            
            cell1.goalTitleLabel.text = goal.goal
            cell1.valueLabel.text = "R$ \(goal.value)"
            cell1.lackLabel.text = "R$ \(goal.lack)"
            
            return cell1
            
        } else if selectedSegment == 2,
            
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "shoppingCell") as? ShoppingCell{
            
            let shopp = shoppingList[indexPath.row]
            
            cell2.storeLabel.text = shopp.store
            cell2.dateLabel.text = shopp.date
            cell2.valueLabel.text = "R$ \(shopp.value)"
            
            return cell2
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if selectedSegment == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "spendingCell") as? SpendingCell
            return cell
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         if selectedSegment == 2 {
            return 128
        }
        
        return UITableView.automaticDimension
    }
 
    
    @IBAction func adicionarControle(_ sender: Any) {
        
        if selectedSegment == 1 {
            performSegue(withIdentifier: "newGoal", sender: "nil")
        } else {
            performSegue(withIdentifier: "newShopping", sender: "nil")
        }
    }
    
    @IBAction func backToControle(_ segue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newGoal" {
            if let goalVC = segue.destination as? AddGoals {
                goalVC.goalScreen = self
            }
        } else if segue.identifier == "newShopping" {
            if let shoppVC = segue.destination as? AddShopping {
                shoppVC.shoppingScreen = self
            }
        }
    }

}
