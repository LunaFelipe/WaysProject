//
//  CustomPubController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 12/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class CustomPubController: UIViewController {
    
    @IBOutlet weak var pubTitle: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var pubTime: UILabel!
    @IBOutlet weak var pubCosts: UILabel!
    @IBOutlet weak var pubDescription: UILabel!
    
    var custom: Customization!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let oCustom = self.custom {
            pubTitle.text = oCustom.title
            pubCosts.text = "R$ \(oCustom.costs)"
            pubTime.text = oCustom.time
            photo.image = oCustom.photo
            pubDescription.text = oCustom.description
        }
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
