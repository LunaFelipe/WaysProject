//
//  AdicionarCustomizacaoTableViewController.swift
//  Projeto Ways
//
//  Created by Felipe Luna Tersi on 25/08/19.
//  Copyright © 2019 Felipe Luna Tersi. All rights reserved.
//

import UIKit

class AddCustom: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    var customizacaoScreen: CustomController?
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var customNameField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBAction func imgButton(_ sender: Any) {
        imagePicker.delegate = self
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
            imagePicker.mediaTypes = ["public.image", "public.movie"]
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
        imagePicker.mediaTypes = ["public.image", "public.movie"]
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneCustomizacao(_ sender: Any) {
        
        customizacaoScreen?.addCustomizacao(custom: Customization(title: customNameField.text ?? "",
                                                                  time: timeField.text ?? "",
                                                                  costs: priceField.text ?? "",
                                                                  photo: imgView.image!, description: descriptionField.text ?? ""))
        
        performSegue(withIdentifier: "backToCustomizacoes", sender: nil)
        
    }
}
