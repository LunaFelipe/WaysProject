//
//  AddItem.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 15/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class AddItemController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    var categorieItem: String?
    var imagePicker = UIImagePickerController()
    var imagePicked = 0
    var imageUrl: String?
    var imageUrl2: String?
    
    var itensScreen: ProductsController?
    
    var pickerCondition = ["Novo", "Usado"]
    
    @IBOutlet var tableViewB: UITableView!
    @IBOutlet weak var titleItem: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var condition: UITextField!
    @IBOutlet weak var categorie: UILabel!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var imageButton2: UIButton!
    //    @IBOutlet weak var descriptionitem: UITextField!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var photo2: UIImageView!
    @IBOutlet weak var descriptionItem: UITextView!
    @IBOutlet weak var descriptionPlaceholder: UILabel!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let conditionPickerView = UIPickerView()
        
        conditionPickerView.delegate = self
        descriptionItem.delegate = self
        titleItem.delegate = self
        price.delegate = self
        condition.delegate = self
        
        descriptionPlaceholder.isHidden = !descriptionItem.text.isEmpty
        
        self.hideKeyboardWhenTappedAround()
        
        condition.inputView = conditionPickerView
        
        showConditionPicker()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(allowRowSelection), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    
    func setTextField(_ aRect: CGRect, _ currentTextField: UITextField) {
        if aRect.contains(currentTextField.frame.origin) {
            
            let tableViewY = tableViewB.frame.origin.y
            
            let convertedTextField = currentTextField.convert(currentTextField.frame.origin, to: self.view)
            
            let frame = CGRect(x: convertedTextField.x,
                               y: convertedTextField.y - tableViewY,
                               width: currentTextField.frame.width,
                               height: currentTextField.frame.height)
            
            self.tableViewB.scrollRectToVisible(frame, animated: true)
        }
    }
    
    func setTextView(_ aRect: CGRect, _ currentTextView: UITextView) {
        if aRect.contains(currentTextView.frame.origin) {
            
            let tableViewY = tableViewB.frame.origin.y
            
            let convertedTextView = currentTextView.convert(currentTextView.frame.origin, to: self.view)
            
            let frame = CGRect(x: convertedTextView.x,
                               y: convertedTextView.y - tableViewY,
                               width: currentTextView.frame.width,
                               height: currentTextView.frame.height)
            
            self.tableViewB.scrollRectToVisible(frame, animated: true)
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            //Keyboard size
            let keyboardRectangle = keyboardFrame.cgRectValue
            let kbSize = keyboardRectangle.size.height
            
            if notification.name == UIResponder.keyboardDidShowNotification ||
                notification.name == UIResponder.keyboardWillChangeFrameNotification {
                
                let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize, right: 0)
                
                self.tableViewB.contentInset = contentInsets
                self.tableViewB.scrollIndicatorInsets = contentInsets
                
                var aRect = self.view.frame
                aRect.size.height -= kbSize
                
                if let currentTextField = view.getSelectedTextField() {
                    setTextField(aRect, currentTextField)
                } else if let currentTextView = view.getSelectedTextView() {
                    setTextView(aRect, currentTextView)
                }
                
            }
            
            if notification.name == UIResponder.keyboardWillHideNotification {
                
                let contentInsets = UIEdgeInsets.zero
                
                self.tableViewB.contentInset = contentInsets
                self.tableViewB.scrollIndicatorInsets = contentInsets
            }
            
        }
    }
    
    @IBAction func photoButtom(_ sender: UIButton) {
        
        imagePicked = sender.tag
        
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
//            imagePicker.allowsEditing = true
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
        
        if imagePicked == 1{
            if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                photo.image = editedImage
            } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                photo.image = image
            }
        } else {
            if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                photo2.image = editedImage
            } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                photo2.image = image
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    
    //Condition picker function
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
    
    func inputMissingFeedback() {
        let textFields: [UITextField] = [titleItem, price, condition]
        for textField in textFields {
            if textField.text?.isEmpty ?? true {
                if #available(iOS 10.0, *) {
                    shakeTextField(textField: textField, for: 1, placeholder: textField.placeholder ?? "Insira um valor", textColor: .black)
                }
            }
        }
        
        if descriptionItem.text.isEmpty {
            if #available(iOS 10.0, *) {
                shakeLabel(label: descriptionPlaceholder, for: 1, labelColor: .lightGray)
            }
        }
        
        //Improve this logic to a generic label
        if categorie.text == "Selecione uma categoria" {
            if #available(iOS 10.0, *) {
                shakeLabel(label: categorie, for: 1, labelColor: .lightGray)
            }
        }
        
        if photo.image == nil {
            if #available(iOS 10.0, *) {
                shakeButton(button: imageButton, for: 1, buttonColor: #colorLiteral(red: 0.1411764706, green: 0.5411764706, blue: 0.2392156863, alpha: 1))
            }
        }
        
        if photo2.image == nil {
            if #available(iOS 10.0, *) {
                shakeButton(button: imageButton2, for: 1, buttonColor: #colorLiteral(red: 0.1411764706, green: 0.5411764706, blue: 0.2392156863, alpha: 1))
            }
        }
        
        // Dismiss keyboard and scroll back to top
        let isAllInformationInputed: Bool = titleItem.text?.isEmpty == false &&
            price.text?.isEmpty == false &&
            condition.text?.isEmpty == false &&
            descriptionItem.text.isEmpty == false &&
            categorie.text != "Selecione uma categoria" &&
            photo.image != nil
        
        if isAllInformationInputed == false {
            for textField in textFields {
                textField.resignFirstResponder()
            }
            descriptionItem.resignFirstResponder()
            
            tableView.scrollsToTop = true
        }
        
    }
    
    @IBAction func doneButtom(_ sender: Any) {
        // Handle lack of input
        let isAllInformationInputed: Bool = titleItem.text?.isEmpty == false &&
            price.text?.isEmpty == false &&
            condition.text?.isEmpty == false &&
            descriptionItem.text.isEmpty == false &&
            categorie.text != "Selecione uma categoria" &&
            photo.image != nil &&
            photo2.image != nil
        
        if isAllInformationInputed {
            
            //add item do firebase
            let currentUser = Auth.auth().currentUser!.uid

            itensScreen?.addItem(item: Item(seller: currentUser, title: titleItem.text ?? "",
                                            price: price.text ?? "",
                                            condition: condition.text ?? "",
                                            categorie: categorie.text ?? "",
                                            description: descriptionItem.text ?? "",
                                            photo: photo.image!,
                                            exchange: output.text ?? "",
                                            isFavorite: false,
                                            photo2: photo2.image!
            ))
            
            var storageRef = Storage.storage().reference().child(currentUser).child(titleItem.text!).child("image1")

            if let uploadData = photo.image!.pngData(){
                storageRef.putData(uploadData, metadata: nil, completion:
                    { (metadata, error) in
                        
                        if error != nil {
                            print(error)
                            return
                        }
                        
                        let imageRef = Storage.storage().reference().child((metadata?.path)!)
                        
                        imageRef.downloadURL { url, error in
                            if let error = error {
                                print(error)
                                return
                            } else {
                                self.imageUrl = "\(url!)"
                                print("URLLLLLLLLLLLLLLLLLLL")
                                print(self.imageUrl)
                            }
                        }
                        
                })
            }
            
            storageRef = Storage.storage().reference().child(currentUser).child(titleItem.text!).child("image1")
            if let uploadData = photo.image!.pngData(){
                storageRef.putData(uploadData, metadata: nil, completion:
                    { (metadata, error) in
                        
                        if error != nil {
                            print(error)
                            return
                        }
                        
                        var imageRef = Storage.storage().reference().child((metadata?.path)!)
                        
                        imageRef.downloadURL { url, error in
                            if let error = error {
                                print("ERRO")
                                print(error)
                                return
                            } else {
                                self.imageUrl = "\(url!)"
                                let value = ItemDatabase(key: self.titleItem.text!, title: self.titleItem.text!, price: self.price.text!, condition: self.condition.text!, categorie: self.categorie.text!, description: self.descriptionItem.text!, imageUrl: self.imageUrl!, imageUrl2: self.imageUrl!, exchange: self.output.text!)
                                
                                self.addItemToDatabase(values: value)
                                
                            }
                        }
                        
//                        imageRef = Storage.storage().reference().child((metadata?.path)!)
                        
//                        imageRef.downloadURL { url, error in
//                            if let error = error {
//                                print(error)
//                                return
//                            } else {
//                                self.imageUrl2 = "\(url!)"
//                                let value = ItemDatabase(key: self.titleItem.text!, title: self.titleItem.text!, price: self.price.text!, condition: self.condition.text!, categorie: self.categorie.text!, description: self.descriptionItem.text!, imageUrl: self.imageUrl!, imageUrl2: self.imageUrl!, exchange: self.output.text!)
//
//                                self.addItemToDatabase(values: value)
//                            }
//                        }
                })
            }
            
            performSegue(withIdentifier: "backToItens", sender: nil)
            
        } else {
            inputMissingFeedback()
        }
        
    }
    
    
    private func addItemToDatabase(values: ItemDatabase){
        let ref = Database.database().reference().root
        guard let userKey = Auth.auth().currentUser?.uid else {return}
        
        ref.child("User").child(userKey).child("produtos").child(titleItem.text!).updateChildValues(values.toAnyObject() as! [AnyHashable : Any])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let footerView = UIView()
        tableView.tableFooterView = footerView
        
        if categorieItem?.isEmpty ?? true {
            categorie.text = "Selecione uma categoria"
        } else {
            categorie.text = categorieItem
        }
    }
    
    @IBAction func backToAddItem (_ segue: UIStoryboardSegue) {
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //Dismiss keyboard when return key is tapped
        if string == "\n" {
            titleItem.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        //Dismiss keyboard when return key is tapped
        if text == "\n" {
            descriptionItem.resignFirstResponder()
            return false
        }
        
        //Limit number of characters
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        return changedText.count <= 300
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        //Hide placeholder when textView isn't empty
        descriptionPlaceholder.isHidden = !descriptionItem.text.isEmpty
        
        // Resize text view
        let lastScrollOffset = tableView.contentOffset
        tableView.beginUpdates()
        tableView.endUpdates()
        tableView.layer.removeAllAnimations()
        tableView.setContentOffset(lastScrollOffset, animated: false)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        tableView.allowsSelection = false
    }
    
    @objc func allowRowSelection(_ notification: NSNotification) {
        if notification.name == UIResponder.keyboardDidHideNotification {
            tableView.allowsSelection = true
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height: CGFloat = 78
        
        switch indexPath.row {
        case 0:
            height = 177
        case 5:
            height = 46 + descriptionItem.frame.height
        case 6:
            height = 64
        default:
            height = 78
        }
        
        return height
    }
    
}

extension UIView {
    // TEXT FIELD
    func getSelectedTextField() -> UITextField? {
        
        let totalTextFields = getTextFieldsInView(view: self)
        
        for textField in totalTextFields{
            if textField.isFirstResponder{
                return textField
            }
        }
        
        return nil
        
    }
    
    func getTextFieldsInView(view: UIView) -> [UITextField] {
        
        var totalTextFields = [UITextField]()
        
        for subview in view.subviews as [UIView] {
            if let textField = subview as? UITextField {
                totalTextFields += [textField]
            } else {
                totalTextFields += getTextFieldsInView(view: subview)
            }
        }
        
        return totalTextFields
    }
    
    // TEXT VIEW
    func getSelectedTextView() -> UITextView? {
        
        let totalTextViews = getTextViewInView(view: self)
        
        for textView in totalTextViews {
            if textView.isFirstResponder{
                return textView
            }
        }
        
        return nil
        
    }
    
    func getTextViewInView(view: UIView) -> [UITextView] {
        
        var totalTextViews = [UITextView]()
        
        for subview in view.subviews as [UIView] {
            if let textView = subview as? UITextView {
                totalTextViews += [textView]
            } else {
                totalTextViews += getTextViewInView(view: subview)
            }
        }
        
        return totalTextViews
    }
}

extension UITableViewController {
    // KEYBOARD
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UITableViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
    }
}

@available(iOS 10.0, *)
extension UITableViewController {
    // Lack of input feedback
    //Shake a textField when detect an error input
    func shakeTextField(textField: UITextField, for duration: TimeInterval, placeholder: String, textColor: UIColor) {
        
        let translation: CGFloat = 10
        
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
            textField.transform = CGAffineTransform(translationX: translation, y: 0)
            textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            textField.textColor = .red
        }
        
        propertyAnimator.addAnimations({textField.transform = CGAffineTransform(translationX: 0, y: 0)}, delayFactor: 0.2)
        
        propertyAnimator.addCompletion { (_) in
            textField.layer.borderWidth = 0
            textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            textField.textColor = textColor
        }
        
        propertyAnimator.startAnimation()
        
        //Vibrate
        UIDevice.vibrate()
    }
    
    //Shake a textView when detect an error input
    func shakeLabel(label: UILabel, for duration: TimeInterval, labelColor: UIColor) {
        let translation: CGFloat = 10
        
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
            label.transform = CGAffineTransform(translationX: translation, y: 0)
            label.textColor = .red
        }
        
        propertyAnimator.addAnimations({label.transform = CGAffineTransform(translationX: 0, y: 0)}, delayFactor: 0.2)
        
        propertyAnimator.addCompletion { (_) in
            label.layer.borderWidth = 0
            label.textColor = labelColor
        }
        
        propertyAnimator.startAnimation()
        
        //Vibrate
        UIDevice.vibrate()
    }
    
    //Shake a button when detect an error input
    func shakeButton(button: UIButton, for duration: TimeInterval, buttonColor: UIColor) {
        
        let translation: CGFloat = 10
        
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
            button.transform = CGAffineTransform(translationX: translation, y: 0)
            button.tintColor = .red
        }
        
        propertyAnimator.addAnimations({button.transform = CGAffineTransform(translationX: 0, y: 0)}, delayFactor: 0.2)
        
        propertyAnimator.addCompletion { (_) in
            button.layer.borderWidth = 0
            button.tintColor = buttonColor
        }
        
        propertyAnimator.startAnimation()
        
        //Vibrate
        UIDevice.vibrate()
    }
}

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
