//
//  BrachoMarkerView.swift
//  Ways
//
//  Created by Matheus Oliveira on 15/10/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import Foundation
import MapKit

@available(iOS 11.0, *)
class BrechoMarkerView: MKMarkerAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {

        guard let brecho = newValue as? Brecho else { return }
        canShowCallout = true
        calloutOffset = CGPoint(x: -5, y: 5)
        markerTintColor = #colorLiteral(red: 0.1411764706, green: 0.5411764706, blue: 0.2392156863, alpha: 1)
        glyphImage = UIImage(named: "logo")
    }
  }
}
