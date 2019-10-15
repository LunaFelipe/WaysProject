//
//  Brecho.swift
//  Ways
//
//  Created by Matheus Oliveira on 15/10/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import Foundation
import MapKit

class Brecho: NSObject, MKAnnotation {
  let name: String?
  let adress: String
  let coordinate: CLLocationCoordinate2D
  
  init(name: String, adress: String, coordinate: CLLocationCoordinate2D) {
    self.name = name
    self.adress = adress
    self.coordinate = coordinate
    
    super.init()
  }
  
  var subtitle: String? {
    return adress
  }
}
