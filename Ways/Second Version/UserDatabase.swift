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
    var locationStreet: String
    var locationNumber: String
    var locationState: String
    var locationCity: String
    var email: String
    
    init(key:String, name: String, profileType: String, contactNumber: String, locationStreet: String, locationNumber: String, locationState: String, locationCity: String, email: String)
    {
        self.ref = nil
        self.key = key
        self.name = name
        self.profileType = profileType
        self.contactNumber = contactNumber
        self.locationStreet = locationStreet
        self.locationNumber = locationNumber
        self.locationState = locationState
        self.locationCity = locationCity
        self.email = email
    }
    
    init?(snapshot: DataSnapshot)
    {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let profileType = value["profileType"] as? String,
            let contactNumber = value["contactNumber"] as? String,
            let locationStreet = value["locationStreet"] as? String,
            let locationNumber = value["locationNumber"] as? String,
            let locationState = value["locationState"] as? String,
            let locationCity = value["locationCity"] as? String,
            let email = value["email"] as? String else { return nil }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
        self.profileType = profileType
        self.contactNumber = contactNumber
        self.locationStreet = locationStreet
        self.locationNumber = locationNumber
        self.locationState = locationState
        self.locationCity = locationCity
        self.email = email
        
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "profileType": profileType,
            "contactNumber": contactNumber,
            "locationStreet" : locationStreet,
            "locationNumber" : locationNumber,
            "locationState" : locationState,
            "locationCity" : locationCity,
            "email" : email,
        ]
    }
    
}
