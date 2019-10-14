//
//  LoginViewController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 18/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit
import FirebaseAuth
import KeychainSwift

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let keyChain = FirebaseAuthManager().keyChain
    let signUpManager = FirebaseAuthManager()

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
        if let email = email.text, let password = password.text {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    self.signUpManager.completeSignIn(id: (user?.user.uid)!)
                    self.performSegue(withIdentifier: "goToMain", sender: nil)
                } else {
                    print(error!._code)
                    self.display(alertController: self.signUpManager.handleError(error!))
                }
            }
        }
    }
    
    
//    @IBAction func registerButton(_ sender: Any) {
//        self.performSegue(withIdentifier: "registerPage1", sender: nil)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.delegate = self
        email.delegate = self
        self.dismissKey()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if keyChain.get("uid") != nil {
            performSegue(withIdentifier: "goToMain", sender: nil)
        }
    }
    
    //dismiss keyboard when return button is tapped
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }

    func display(alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func backToFirstScreen(_ segue: UIStoryboardSegue) {
        
    }
    
}

extension UIViewController {
    
    //dismiss keyboard when tap anywhere
    func dismissKey(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
