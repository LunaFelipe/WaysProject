//
//  AddShopping.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 10/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class AddShopping: UITableViewController {
    
    var shoppingScreen: ControlController?
    var datePicker = UIDatePicker()

    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var storeField: UITextField!
    @IBOutlet weak var date: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
    }
    
    //Escolha de Data
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Confirmar", style: .plain, target: self, action: #selector(donedatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        date.inputAccessoryView = toolbar
        date.inputView = datePicker
        
    }
    
    //Confirmar Data Escolhida
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "EEEE, d MM, yyyy"
        date.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    //Cancelar Data Escolhida
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    //Confirmar adição de compra
    @IBAction func doneShopping(_ sender: Any) {
        
        shoppingScreen?.addShopping(shopp: Shopping(store: storeField.text ?? "",
                                                   date: dateField.text ?? "",
                                                   value: valueField.text ?? ""))
        
        performSegue(withIdentifier: "backToControle", sender: nil)
        
    }
}
