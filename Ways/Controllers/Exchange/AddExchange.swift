//
//  AdicionarTrocaTableViewController.swift
//  Projeto Ways
//
//  Created by Felipe Luna Tersi on 11/08/19.
//  Copyright © 2019 Felipe Luna Tersi. All rights reserved.
//

import UIKit

class AddExchange: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    var trocaScreen: ExchangeController?
    
    let imagePicker = UIImagePickerController()

    @IBOutlet weak var clotheImage: UIImageView!
    @IBOutlet weak var clotheTextField: UITextField!
    @IBOutlet weak var conditionTextField: UITextField!
    @IBOutlet weak var preferenceTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var pickOption = ["1 / 10", "2 / 10", "3 / 10", "4 / 10", "5 / 10", "6 / 10", "7 / 10", "8 / 10", "9 / 10", "10 / 10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        
        conditionTextField.inputView = pickerView
        
        showDatePicker()
    }
    
    func showDatePicker(){
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Confirmar", style: .plain, target: self, action: #selector(donedatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        conditionTextField.inputAccessoryView = toolbar
    }
    
    @objc func donedatePicker(){
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        conditionTextField.text = "\(pickOption[row])"
    }
    
    @IBAction func imgButton(_ sender: Any) {
//        imagePicker.delegate = self
        //        imagePicker.allowsEditing = true
        //        imagePicker.sourceType = .camera
        ////        imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
        //        self.present(imagePicker, animated: true, completion: nil)
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
            clotheImage.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func doneTroca(_ sender: Any) {
        
        trocaScreen?.addTroca(troca: Exchange(title: clotheTextField.text ?? "",
                                           condition: conditionTextField.text ?? "",
                                           preference: preferenceTextField.text ?? "",
                                           photo: clotheImage.image!,
                                           description: descriptionTextField.text ?? ""))
        
        performSegue(withIdentifier: "backtoTrocas", sender: nil)
    }
}


