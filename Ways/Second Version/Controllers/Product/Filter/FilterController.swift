//
//  FilterController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 22/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class FilterController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var selectedCategories: [String] = []
    var categorieItem: String?
    var pickerCondition = ["Novo", "Usado"]
    var priceSelected: Int = 100
    var distanceSelected: Int = 20
    var isFilterApplied: Bool = false

    @IBOutlet weak var condition: UITextField!
    @IBOutlet weak var categorie: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var distanceSlider: UISlider!
    
    @IBAction func clearButtom(_ sender: Any) {
        
        priceSelected = 100
        priceSlider.value = Float(priceSelected)
        price.text = "R$ \(priceSelected)"
        
        distanceSelected = 20
        distanceSlider.value = Float(distanceSelected)
        distance.text = "\(distanceSelected) km"
        
        condition.text = "Novo ou usado"
        condition.textColor = .lightGray
        
        categorie.text = "Selecione uma categoria"
        
        isFilterApplied = false
    }
    
    @IBAction func filterButton(_ sender: Any) {
        
        isFilterApplied = true
        performSegue(withIdentifier: "filtrar", sender: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let conditionPickerView = UIPickerView()
        conditionPickerView.delegate = self
        condition.inputView = conditionPickerView

        showConditionPicker()
    }
    
    func showConditionPicker(){

        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelConditionPicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Confirmar", style: .plain, target: self, action: #selector(doneConditionPicker));

        toolbar.tintColor = #colorLiteral(red: 0.7607844472, green: 0.235294193, blue: 0.5333334208, alpha: 1)
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

        condition.inputAccessoryView = toolbar
    }

    @objc func doneConditionPicker(){
        self.view.endEditing(true)
        condition.textColor = .black
    }

    @objc func cancelConditionPicker(){
        self.view.endEditing(true)
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerCondition.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerCondition[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        condition.text = "\(pickerCondition[row])"
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func priceValue(_ sender: UISlider) {
        
        let currentValue = Int(sender.value)
        self.priceSelected = currentValue
        price.text = " R$ \(currentValue)"
        
    }
    
    @IBAction func distanceValue(_ sender: UISlider) {
        
        let currentValue = Int(sender.value)
        self.distanceSelected = currentValue
        distance.text = "\(currentValue) km"
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        if priceSelected != 100 {
            priceSlider.value = Float(priceSelected)
            price.text = " R$ \(priceSelected)"
        }
        if distanceSelected != 20 {
            distanceSlider.value = Float(distanceSelected)
            distance.text = "\(distanceSelected) km"
        }
    }

    @IBAction func returnToFilter(_ segue: UIStoryboardSegue) {
        
            if let category = segue.source as? CategorieFilterController {
                self.categorie.text = category.categorias
                self.selectedCategories = category.selectedCategories
                print(self.categorie.text)
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "filtrar":
            print("segue")
        default:
            print("unexpected segue identifier")
        }
    }
    
}
