//
//  AddItem.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 15/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class AddItem: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var categorieItem: String?
    let imagePicker = UIImagePickerController()
    
    var itensScreen: ProductsController?
    
    var pickerCondition = ["Novo", "Usado"]
    
    @IBOutlet weak var titleItem: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var condition: UITextField!
    @IBOutlet weak var categorie: UILabel!
    @IBOutlet weak var descriptionitem: UITextField!
    @IBOutlet weak var photo: UIImageView!

    @IBOutlet weak var output: UILabel!
    
    @IBAction func `switch`(_ sender: UISwitch) {
        
        if (sender.isOn == true )
        {
            output.text = "Sim"
        }
        else
        {
            output.text = "Não"
        }
        
    }
    
    @IBAction func photoButtom(_ sender: UIButton) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Galeria", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancelar", style: .cancel, handler: nil))
        
        //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender as? UIView
            //            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Alerta", message: "Você não tem a camera habilitada", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Choose image from camera roll
    
    func openGallary(){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photo.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
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
    
    @IBAction func doneButtom(_ sender: Any) {
        
        itensScreen?.addItem(item: Item(title: titleItem.text ?? "",
                                        price: price.text ?? "",
                                        condition: condition.text ?? "",
                                        categorie: categorie.text ?? "",
                                        description: descriptionitem.text ?? "",
                                        photo: photo.image!,
                                        exchange: output.text ?? "",
                                        isFavorite: false 
                                              ))
        performSegue(withIdentifier: "backToItens", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if categorieItem?.isEmpty ?? true {
            categorie.text = "Selecione uma categoria"
        } else {
            categorie.text = categorieItem
        }
    }
    
    @IBAction func backToAddItem (_ segue: UIStoryboardSegue) {
        
    }

}
