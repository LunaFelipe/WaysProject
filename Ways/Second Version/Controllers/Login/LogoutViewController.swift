//
//  LogoutViewController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 18/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift

class LogoutViewController: UIViewController {

    @IBAction func logoutButtom(_ sender: Any) {
            
            let firebaseAuth = Auth.auth()
            do{
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
            KeychainSwift().delete("uid")
        
//           dismiss(animated: true, completion: nil)
            
                  performSegue(withIdentifier: "backToLogin", sender: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
