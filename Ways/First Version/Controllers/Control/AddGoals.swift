//
//  AddGoals.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 09/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class AddGoals: UITableViewController {
    
    var goalScreen: ControlController?

    @IBOutlet weak var goalField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var reservedField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func doneGoal(_ sender: Any) {
        
        let firstValue = Double(valueField.text!)
        let secondValue = Double(reservedField.text!)
        let outputValue = Double(firstValue! - secondValue!)
        
        resultLabel.text = "\(outputValue)"
        
        goalScreen?.addGoal(goal: Goals(goal: goalField.text ?? "",
                                        value : valueField.text ?? "",
                                        lack: resultLabel.text ?? ""))
        
        performSegue(withIdentifier: "backToControle", sender: nil)
    }
}
