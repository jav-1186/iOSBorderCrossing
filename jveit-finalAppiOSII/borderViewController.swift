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
    
    var RosemontTrain = ("","")
    var CumberlandTrain = ("","")
    var HarlemTrain = ("","")
    var JeffersonTrain = ("", "")
    
    // Points of interest
    let points =
    [
        (lat: 32.666735, lon: -115.499422, name: "Close Proximity to Mexican Border"),
        (lat: 32.664685, lon: -115.499830, name: "Mexico Border"),
        (lat: 41.982322, lon: -87.807626, name: "Harlem Blue Line Station"),
        (lat: 41.971639, lon: -87.763435, name: "Jefferson Park Blue Line Station")
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
    
    // Adding annotations for the trains
    var annotation: MKAnnotation?
    var borderCrossing = MKPointAnnotation()
    var cumberland = MKPointAnnotation()
    var harlem = MKPointAnnotation()
    var jeffP = MKPointAnnotation()
    
    
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
        
        // Adding all of the trains with live data from CTA API
        borderCrossing.title = "Mexico Border"
        borderCrossing.coordinate = CLLocationCoordinate2D(latitude: 32.664685, longitude: -115.499830)
        let placeR = Place(borderCrossing.coordinate, "Mexico Border")
        
        cumberland.title = "Cumberland Blue Line Train"
        cumberland.coordinate = CLLocationCoordinate2D(latitude: Double(CumberlandTrain.0) ?? 47.1, longitude: Double(CumberlandTrain.1) ?? 87.1)
        let placeC = Place(cumberland.coordinate, "Cumberland Train")
        
        harlem.title = "Harlem Blue Line Train"
        harlem.coordinate = CLLocationCoordinate2D(latitude: Double(HarlemTrain.0) ?? 47.1, longitude: Double(HarlemTrain.1) ?? 87.1)
        let placeH = Place(harlem.coordinate, "Harlem Train")
        
        jeffP.title = "Jefferson Park Blue Line Train"
        jeffP.coordinate = CLLocationCoordinate2D(latitude: Double(JeffersonTrain.0) ?? 47.1, longitude: Double(JeffersonTrain.1) ?? 87.1)
        let placeJ = Place(jeffP.coordinate, "Jefferson Park Train")
        
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
            showAlert(withTitle:"You are about to Cross the Mexican Border", message: "Please ensure you have the proper identification (Passport, insurance, drivers license)")
            flagP.image = UIImage(named:"mexico")
            infoT.text = "When you cross the Mexico border your car will go through customs. If your light is green, you will continue to pass. If you hit a red signal, your luggage and vehicle will be searched."
            infoP.image = UIImage(named:"declare")
        }
        
        else if region.identifier == "Cumberland Blue Line Station"
        {
            var cumberlandS = MKPointAnnotation()
            
            cumberlandS.coordinate = CLLocationCoordinate2D(latitude: 41.984383, longitude: -87.837722)
            let placeCS = Place(cumberlandS.coordinate, "Cumberland Station")
            mapView.addAnnotation(placeCS)
        }
        
        else if region.identifier == "Harlem Blue Line Station"
        {
            var harlemS = MKPointAnnotation()
           
            
            harlemS.coordinate = CLLocationCoordinate2D(latitude: 41.982322, longitude: -87.807626)
            let placeHS = Place(harlemS.coordinate, "Harlem Station")
            mapView.addAnnotation(placeHS)
        }
        
        else if region.identifier == "Jefferson Park Blue Line Station"
        {
            var jpS = MKPointAnnotation()
            
            
            jpS.coordinate = CLLocationCoordinate2D(latitude: 41.971639, longitude: -87.763435)
            let placeJPS = Place(jpS.coordinate, "Jefferson Park Station")
            mapView.addAnnotation(placeJPS)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion)
    {
        NSLog("Exit region \(region)")
        enterR.text = "Exit \(region.identifier)"
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error)
    {
        NSLog("Error \(error)")
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
