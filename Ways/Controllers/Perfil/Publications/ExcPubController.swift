//
//  ExcPubController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 12/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class ExcPubController: UIViewController {

    @IBOutlet weak var pubDescription: UILabel!
    @IBOutlet weak var preference: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var pubTitle: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    var troca: Exchange!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let oTroca = self.troca {
            pubTitle.text = oTroca.title
            condition.text = oTroca.condition
            preference.text = oTroca.preference
            photo.image = oTroca.photo
            pubDescription.text = oTroca.description
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
