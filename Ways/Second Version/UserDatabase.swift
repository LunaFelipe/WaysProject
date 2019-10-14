//
//  UserDatabase.swift
//  Ways
//
//  Created by Marina Miranda Aranha on 24/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import Foundation
import Firebase

struct UserDatabase
{
    
    let ref: DatabaseReference?
    let key: String
    var name: String
    var profileType: String
    var contactNumber: String
    var location: String
    var email: String
    
    init(key:String, name: String, profileType: String, contactNumber: String, location: String, email: String)
    {
        self.ref = nil
        self.key = key
        self.name = name
        self.profileType = profileType
        self.contactNumber = contactNumber
        self.location = location
        self.email = email
    }
    
    init?(snapshot: DataSnapshot)
    {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let profileType = value["profileType"] as? String,
            let contactNumber = value["contactNumber"] as? String,
            let location = value["location"] as? String,
            let email = value["email"] as? String else { return nil }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
        self.profileType = profileType
        self.contactNumber = contactNumber
        self.location = location
        self.email = email
        
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "profileType": profileType,
            "contactNumber": contactNumber,
            "location" : location,
            "email" : email,
        ]
    }
    
}
