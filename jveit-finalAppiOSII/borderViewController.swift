//
//  borderViewController.swift
//  jveit-finalAppiOSII
//
//  Created by Jeffrey Veit on 5/19/21.
//

import UIKit
import CoreLocation
import MapKit

class borderViewController: UIViewController, CLLocationManagerDelegate {

   
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationL: UILabel!
    @IBOutlet weak var enterR: UILabel!
    @IBOutlet weak var flagP: UIImageView!
    @IBOutlet weak var infoT: UILabel!
    @IBOutlet weak var infoP: UIImageView!
    
    
    let locationManager = CLLocationManager()
    
    // Points of interest
    let points =
    [
        (lat: 32.666735, lon: -115.499422, name: "Close Proximity to Mexican Border"),
        (lat: 32.664685, lon: -115.499830, name: "Mexico Border"),
        (lat: 32.663696, lon: -115.496192, name: "Oxxo Market"),
        (lat: 32.664640, lon: -115.487578, name: "Ropa de Mexicali"),
        (lat: 32.660910, lon: -115.479960, name: "Plaza Cachanilla"),
    ]
    
    var regions = [CLCircularRegion]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let status = locationManager.authorizationStatus
        if status == .denied || status == .restricted
        {
            locationL.text = "Location service not authorized"
        }
        
        else
        {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 1 // meter
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            
            mapView.mapType = .standard
            mapView.showsUserLocation = true
            mapView.showsBuildings = true
            
            if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self)
            {
                for p in points
                {
                    let center = CLLocationCoordinate2D(latitude: p.lat, longitude: p.lon)
                    let region = CLCircularRegion(center: center, radius: 10, identifier: p.name)
                    region.notifyOnEntry = true
                    region.notifyOnExit = true
                    regions.append(region)
                }
            }
            
            else
            {
                showAlert(withTitle:"Error", message: "Geofencing is not supported on this device!")
            }
            
        }

    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.startUpdatingLocation()
        }
        
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) &&
            !regions.isEmpty
        {
            for region in regions
            {
                locationManager.startMonitoring(for: region)
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
        for region in regions
        {
            locationManager.stopMonitoring(for: region)
        }
    }
    
    // Adding annotations for the points of interest
    var annotation: MKAnnotation?
    var borderCrossing = MKPointAnnotation()
    var oxxo = MKPointAnnotation()
    var ropa = MKPointAnnotation()
    var plaza = MKPointAnnotation()
    
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        
        NSLog("(\(location.coordinate.latitude), \(location.coordinate.longitude))")
        
        locationL.text =
            "Latitude: " + String(format: "%.4f", location.coordinate.latitude) +
            "\nLongitude: " +  String(format: "%.4f", location.coordinate.longitude) 
        
        mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        
        if mapView.isPitchEnabled
        {
            mapView.setCamera(MKMapCamera(lookingAtCenter: location.coordinate, fromDistance: 1000, pitch: 60, heading: 0), animated: true)
        }
        
        if annotation != nil
        {
            mapView.removeAnnotation(annotation!)
        }
        
        // Adding all of the points of interest to the map
        borderCrossing.title = "Mexico Border"
        borderCrossing.coordinate = CLLocationCoordinate2D(latitude: 32.664685, longitude: -115.499830)
        let placeR = Place(borderCrossing.coordinate, "Mexico Border")
        
        oxxo.title = "Oxxo Market"
        oxxo.coordinate = CLLocationCoordinate2D(latitude: 32.663696, longitude: -115.496192)
        let placeC = Place(oxxo.coordinate, "Oxxo")
        
        ropa.title = "Ropa de Mexicali"
        ropa.coordinate = CLLocationCoordinate2D(latitude: 32.664640, longitude: -115.487578)
        let placeH = Place(ropa.coordinate, "Ropa de Mexicali")
        
        plaza.title = "Plaza Cachanilla"
        plaza.coordinate = CLLocationCoordinate2D(latitude: 32.660910, longitude: -115.479960)
        let placeJ = Place(plaza.coordinate, "Plaza Cachanilla")
        
        let place = Place(location.coordinate, "Me")
        mapView.addAnnotation(place)
        mapView.addAnnotation(placeR)
        mapView.addAnnotation(placeC)
        mapView.addAnnotation(placeH)
        mapView.addAnnotation(placeJ)
        annotation = place
        
    }
 
    // Based on where you are located, the relevant information is displayed
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion)
    {
        NSLog("Enter region \(region)")
        enterR.text = "Enter \(region.identifier)"
        
        if region.identifier == "Mexico Border"
        {
            var border = MKPointAnnotation()
            border.title = "Mexico Border"
            border.coordinate = CLLocationCoordinate2D(latitude: 32.664685, longitude: -115.499830)
            let placeR = Place(borderCrossing.coordinate, "Mexico Border")
            showAlert(withTitle:"You are about to Cross the Mexican Border", message: "Please ensure you have the proper identification (*Passport, *Insurance, *Drivers License)")
            flagP.image = UIImage(named:"mexico")
            infoT.text = "When you cross the Mexico border your car will go through customs. If your light is green, you will continue to pass. If you hit a red signal, your luggage and vehicle will be searched."
            infoP.image = UIImage(named:"declare")
        }
        
        else if region.identifier == "Oxxo Market"
        {
            var oxxo = MKPointAnnotation()
            
            oxxo.coordinate = CLLocationCoordinate2D(latitude: 32.663696, longitude: -115.496192)
            let placeCS = Place(oxxo.coordinate, "Oxxo")
            mapView.addAnnotation(placeCS)
            showAlert(withTitle:"Oxxo Market", message: "We recommend stopping here for water, snacks, or if you need to use the restroom.")
            infoT.text = "Oxxo is a Mexican chain of convenience stores, with over 18,000 stores across Latin America. It is the largest chain of convenience stores in Latin America. Its headquarters are in Monterrey, Nuevo León."
            infoP.image = UIImage(named:"Oxxo")
        }
        
        else if region.identifier == "Ropa de Mexicali"
        {
            var ropa = MKPointAnnotation()
            
            ropa.coordinate = CLLocationCoordinate2D(latitude: 32.664640, longitude: -115.487578)
            let placeCS = Place(ropa.coordinate, "Ropa de Mexicali")
            mapView.addAnnotation(placeCS)
            showAlert(withTitle:"Ropa de Mexicali", message: "Stop here to purchase clothing native to Northern Mexico!.")
            infoT.text = "Contains typical clothing worn in Northern Mexico. You can find shirts, shoes, pants and even Cowboy hats!"
            infoP.image = UIImage(named:"Ropa de Mexicali")
        }
        
        else if region.identifier == "Plaza Cachanilla"
        {
            var plaza = MKPointAnnotation()
            
            plaza.coordinate = CLLocationCoordinate2D(latitude: 32.660910, longitude: -115.479960)
            let placeCS = Place(plaza.coordinate, "Plaza Cachanilla")
            mapView.addAnnotation(placeCS)
            showAlert(withTitle:"Plaza Cachanilla", message: "Great place to cool off and great an ice cream cone.")
            infoT.text = "Plaza Cachanilla contains a many variety of stores such as La Ley, Walmart. and boasts a food court with options such as tacos, coffee, or chinese food."
            infoP.image = UIImage(named:"Plaza Cachanilla")
        }
    }
    
    // Notify user when leaving POI area
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion)
    {
        NSLog("Exit region \(region)")
        enterR.text = "Exit \(region.identifier)"
    }
    
    // Error logging
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error)
    {
        NSLog("Error \(error)")
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Helper function to display alerts
    func showAlert(withTitle title: String?, message: String?)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    class Place : NSObject, MKAnnotation
    {
        
        var coordinate: CLLocationCoordinate2D
        var title: String?
        var subtitle: String?
        
        init(_ coordinate: CLLocationCoordinate2D,
             _ title: String? = nil,
             _ subtitle: String? = nil) {
            self.coordinate = coordinate
            self.title = title
            self.subtitle = subtitle
        }
    }

}
