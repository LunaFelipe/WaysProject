//
//  Brecho.swift
//  Ways
//
//  Created by Matheus Oliveira on 15/10/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Brecho: NSObject, MKAnnotation {
  let title: String?
  let address: String
  let coordinate: CLLocationCoordinate2D
  
  init(title: String, address: String, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.address = address
    self.coordinate = coordinate
    
    super.init()
  }
    var subtitle: String? {
      return address
    }
    
    func mapItem() -> MKMapItem {
      let addressDict = [CNPostalAddressStreetKey: subtitle!]
      let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
      let mapItem = MKMapItem(placemark: placemark)
      mapItem.name = title
      return mapItem
    }
}
