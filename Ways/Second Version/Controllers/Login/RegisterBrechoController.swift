//
//  RegisterBrechoController.swift
//  Ways
//
//  Created by Marina Miranda Aranha on 14/10/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class RegisterBrechoController: UITableViewController {
    
    @IBOutlet weak var profileType: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var contactNumber: UITextField!
    @IBOutlet weak var locationStreet: UITextField!
    @IBOutlet weak var locationNumber: UITextField!
    @IBOutlet weak var locationState: UITextField!
    @IBOutlet weak var locationCity: UITextField!
    
    var address: String = ""
    
    let signUpManager = FirebaseAuthManager()

    @IBAction func registerButton(_ sender: Any) {
        if let email = email.text, let password = password.text {
            self.signUpManager.createUser(email: email, password: password) {[weak self] (success) in
                guard let `self` = self else { return }
                var message: String = ""
                if (success) {
                    message = "User was sucessfully created."

                    let item = UserDatabase(key: self.name.text!, name: self.name.text!, profileType: self.profileType.text!, contactNumber: self.contactNumber.text!, locationStreet: self.locationStreet.text!, locationNumber: self.locationNumber.text!, locationState: self.locationState.text!, locationCity: self.locationCity.text!, email: self.email.text!)

                    let ref = Database.database().reference()
                    guard let userKey = Auth.auth().currentUser?.uid else {return}
                ref.child("User-Info").child(userKey).updateChildValues(item.toAnyObject() as! [AnyHashable : Any])
                    
                    self.buildUserAdress()

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
    
    func buildUserAdress() {
        // Grouping address information so we can
        // transform the address in a CLLocationCoordinate2D
        self.address = locationStreet.text! + ", " +
                       locationNumber.text! + ", " +
                       locationState.text! + ", " +
                       locationCity.text! + ", Brazil"
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
           if((error) != nil){
            print("Error", error ?? "Could not get user coordinates")
           }
           if let placemark = placemarks?.first {
              let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
              print(coordinates)
              // Need to send these coordinates to FireBase
              }
            })
    }
}
