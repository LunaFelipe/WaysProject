//
//  ItemDatabase.swift
//  Ways
//
//  Created by Marina Miranda Aranha on 23/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import Foundation
import Firebase

struct ItemDatabase
{
    
    let ref: DatabaseReference?
    let key: String
    var title: String
    var price: String
    var condition: String
    var categorie: String
    var descript: String
    var imageUrl: String
    var imageUrl2: String
    var exchange: String
    
    init(key:String, title: String, price: String, condition: String, categorie: String, description: String, imageUrl: String, imageUrl2: String, exchange: String)
    {
        self.ref = nil
        self.key = key
        self.title = title
        self.price = price
        self.condition = condition
        self.categorie = categorie
        self.descript = description
        self.imageUrl = imageUrl
        self.imageUrl2 = imageUrl2
        self.exchange = exchange
    }
    
    init?(snapshot: DataSnapshot)
    {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let title = value["title"] as? String,
            let price = value["price"] as? String,
            let condition = value["condition"] as? String,
            let categorie = value["categorie"] as? String,
            let description = value["description"] as? String,
            let imageUrl = value["imageUrl"] as? String,
            let imageUrl2 = value["imageUrl2"] as? String,
            let exchange = value["exchange"] as? String else { return nil }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.title = title
        self.price = price
        self.condition = condition
        self.categorie = categorie
        self.descript = description
        self.imageUrl = imageUrl
        self.imageUrl2 = imageUrl2
        self.exchange = exchange
        
    }
    
    func toAnyObject() -> Any {
        return [
            "title": title,
            "price": price,
            "condition": condition,
            "categorie" : categorie,
            "descript" : descript,
            "imageUrl" : imageUrl,
            "imageUrl2" : imageUrl2,
            "exchange" : exchange,
        ]
    }
    
}
