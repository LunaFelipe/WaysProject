//
//  Switcher.swift
//  Ways
//
//  Created by Marina Miranda Aranha on 13/11/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Switcher {
    
    static func updateRootVC(){
        
        var rootVC : UIViewController?
        var status = false
        
        if Auth.auth().currentUser != nil {
            status = true
        } else {
           status = false
        }
               

        if(status == true){
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        }else{
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navVC")
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        
    }
    
}
