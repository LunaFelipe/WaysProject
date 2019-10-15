//
//  MapController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 16/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapController: UIViewController {
    
    
    @IBOutlet var mapView: MKMapView!
    
    let brecho = Brecho(name: "King David Kalakaua",
      adress: "Waikiki Gateway Park",
      coordinate: CLLocationCoordinate2D(latitude: -22.895667, longitude: -47.077630))

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            mapView.register(BrechoMarkerView.self,
                             forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        }
        mapView.addAnnotation(brecho)

        // Do any additional setup after loading the view.
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

extension CLLocation {
    func geocode(completion: @escaping (_ placemark: [CLPlacemark]?, _ error: Error?) -> Void)  {
        CLGeocoder().reverseGeocodeLocation(self, completionHandler: completion)
    }
}
