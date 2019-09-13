//
//  ViewController.swift
//  Ways
//

import UIKit
import BMSCore


import SwiftCloudant



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)

        

        if let contents = Bundle.main.path(forResource:"BMSCredentials", ofType: "plist"), let dictionary = NSDictionary(contentsOfFile: contents) {
            let url = URL(string: dictionary["cloudantUrl"] as! String)
            let client = CouchDBClient(url:url!,
                                       username:dictionary["cloudantUsername"] as? String,
                                       password:dictionary["cloudantPassword"] as? String)
        }

        
        
        
    }
    
    @objc
    func didBecomeActive(_ notification: Notification) {
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
