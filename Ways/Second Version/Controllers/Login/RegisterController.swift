//
//  RegisterController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 19/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit
import Firebase

class RegisterController: UITableViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var profileType: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var contactNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    
    let signUpManager = FirebaseAuthManager()
    
    @IBAction func registerButtom(_ sender: Any) {
        print("AAAAA")
        print(name.text)
        if let email = email.text, let password = password.text {
            self.signUpManager.createUser(email: email, password: password) {[weak self] (success) in
                guard let `self` = self else { return }
                var message: String = ""
                if (success) {
                    message = "User was sucessfully created."
                    
                    let item = UserDatabase(key: self.name.text!, name: self.name.text!, profileType: self.profileType.text!, contactNumber: self.contactNumber.text!, location: self.location.text!, email: self.email.text!)
                    
                    let ref = Database.database().reference()
                    guard let userKey = Auth.auth().currentUser?.uid else {return}
                ref.child("User-Info").child(userKey).updateChildValues(item.toAnyObject() as! [AnyHashable : Any])
                    
                    self.navigationController?.dismiss(animated: true)
                    
                } else {
                    message = "There was an error."
                }
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.display(alertController: alertController)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func display(alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }
    
}
