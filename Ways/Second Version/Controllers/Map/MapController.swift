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
    
    let locationManager = CLLocationManager()
    
    // Adding some "brechos" to see how it works
    // before sending it to the firebase
    let miaBrecho = Brecho(title: "Mia Brechó",
      address: "Av. Francisco Glicério, 473 - Centro, Campinas - SP",
      coordinate: CLLocationCoordinate2D(latitude: -22.910018, longitude: -47.057121))
    
    let brechoBaroni = Brecho(title: "Brechó  Baroni",
    address: "Av. Albino J. B. de Oliveira, 998 - Barão Geraldo, Campinas - SP",
    coordinate: CLLocationCoordinate2D(latitude: -22.829647, longitude: -47.078668))
    
    let brechoFilo = Brecho(title: "Brechó Dona Filó",
    address: "Galeria Baronesa - R. Horácio Leonardi, 98 - Loja 09 - Barão Geraldo, Campinas - SP",
    coordinate: CLLocationCoordinate2D(latitude: -22.828643, longitude: -47.079641))
    
    let brechoDonaOnca = Brecho(title: "Brechó Dona Onça",
    address: "Av. Santa Isabel, 518 - Vila Santa Isabel, Campinas - SP",
    coordinate: CLLocationCoordinate2D(latitude: -22.829552, longitude: -47.079780))
    
    let brechoTrapo = Brecho(title: "Brechó Trapo",
    address: "Rua Antônio Galvão de Oliveira Barros, 59 - Sala 2 - Barão Geraldo, Campinas - SP",
    coordinate: CLLocationCoordinate2D(latitude: -22.824126, longitude: -47.082855))
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      checkLocationAuthorizationStatus()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.userTrackingMode = .follow
        self.locationManager.requestWhenInUseAuthorization()
        mapView.register(BrechoMarkerView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.delegate = self
        mapView.addAnnotation(miaBrecho)
        mapView.addAnnotation(brechoBaroni)
        mapView.addAnnotation(brechoFilo)
        mapView.addAnnotation(brechoDonaOnca)
        mapView.addAnnotation(brechoTrapo)
        
        let centerLocationButton = MKUserTrackingButton(mapView: mapView)
        centerLocationButton.tintColor = #colorLiteral(red: 0.1411764706, green: 0.5411764706, blue: 0.2392156863, alpha: 1)
        centerLocationButton.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor
        centerLocationButton.layer.borderColor = UIColor(white: 1, alpha: 0.8).cgColor
        centerLocationButton.layer.borderWidth = 1
        centerLocationButton.layer.cornerRadius = 5
        centerLocationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(centerLocationButton)
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as? CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        }
        
        if locationManager.location != nil {
            centerMapOnLocation(location: locationManager.location!)
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: 10000,
                                                  longitudinalMeters: 10000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as! CLLocation

        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

        self.mapView.setRegion(region, animated: true)
    }

    
    func checkLocationAuthorizationStatus() {
      if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
        mapView.showsUserLocation = true
      } else {
        locationManager.requestWhenInUseAuthorization()
      }
    }
}

extension CLLocation {
    func geocode(completion: @escaping (_ placemark: [CLPlacemark]?, _ error: Error?) -> Void)  {
        CLGeocoder().reverseGeocodeLocation(self, completionHandler: completion)
    }
}

extension MapController: MKMapViewDelegate {
    
    // Adds subtitle to the map annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
        guard let annotation = annotation as? Brecho else { return nil }
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
        }

        // Opens route in maps
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
            calloutAccessoryControlTapped control: UIControl) {
          let location = view.annotation as! Brecho
          let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
          location.mapItem().openInMaps(launchOptions: launchOptions)
        }
}
