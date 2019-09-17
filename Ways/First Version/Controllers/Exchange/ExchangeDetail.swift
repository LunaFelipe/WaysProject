//
//  TrocaDetailViewController.swift
//  Projeto Ways
//
//  Created by Felipe Luna Tersi on 29/08/19.
//  Copyright © 2019 Felipe Luna Tersi. All rights reserved.
//

import UIKit

class ExchangeDetail: UIViewController {
    
    var troca: Exchange!
    
    var likePressed: Bool = false
    
    @IBOutlet weak var imgDetail: UIImageView!
    @IBOutlet weak var preferenceDetail: UILabel!
    @IBOutlet weak var conditionDetail: UILabel!
    @IBOutlet weak var trocaDetail: UILabel!
    @IBOutlet weak var descriptionDetail: UILabel!
    
    @IBAction func favoriteButtom(_ sender: Any) {
        
        if likePressed == false {
            likePressed = true
            ExcFavoriteList.shared.favoriteExcArray.append(self.troca)
            return
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let oTroca = self.troca {
            trocaDetail.text = oTroca.title
            conditionDetail.text = oTroca.condition
            preferenceDetail.text = oTroca.preference
            imgDetail.image = oTroca.photo
            descriptionDetail.text = oTroca.description
        }
        // Do any additional setup after loading the view.
    }
}

//extension Array where Element: Equatable {
//
//    // Remove first collection element that is equal to the given `object`:
//    mutating func remove(object: Element) {
//        guard let index = firstIndex(of: object) else {return}
//        remove(at: index)
//    }
//
//}
