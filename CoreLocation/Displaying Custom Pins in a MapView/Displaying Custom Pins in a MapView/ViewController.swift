//
//  ViewController.swift
//  Displaying Custom Pins in a MapView
//
//  Created by Domenico Solazzo on 19/05/15.
//  License MIT
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    var mapView: MKMapView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        mapView = MKMapView()
    }
    
    /* We have a pin on the map, now zoom into it and make that pin
    the center of the map */
    func setCenterOfMapToLocation(_ location: CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func addPinToMapView(){
        
        /* These are just sample locations */
        let purpleLocation = CLLocationCoordinate2D(latitude: 58.592737,
            longitude: 16.185898)
        
        let blueLocation = CLLocationCoordinate2D(latitude: 58.593038,
            longitude: 16.188129)
        
        let redLocation = CLLocationCoordinate2D(latitude: 58.591831,
            longitude: 16.189073)
        
        let greenLocation = CLLocationCoordinate2D(latitude: 58.590522,
            longitude: 16.185726)
        
        /* Create the annotations using the location */
        let purpleAnnotation = MyAnnotation(coordinate: purpleLocation,
            title: "Purple",
            subtitle: "Pin",
            pinColor: .Purple)
        
        /* This calls the convenience constructor which will by default
        create a blue pin for us */
        let blueAnnotation = MyAnnotation(coordinate: blueLocation,
            title: "Blue",
            subtitle: "Pin")
        
        let redAnnotation = MyAnnotation(coordinate: redLocation,
            title: "Red",
            subtitle: "Pin",
            pinColor: .Red)
        
        let greenAnnotation = MyAnnotation(coordinate: greenLocation,
            title: "Green",
            subtitle: "Pin",
            pinColor: .Green)
        
        /* And eventually add them to the map */
        mapView.addAnnotations([purpleAnnotation,
            blueAnnotation,
            redAnnotation,
            greenAnnotation])
        
        /* And now center the map around the point */
        setCenterOfMapToLocation(purpleLocation)
        
    }
    
    func mapView(_ mapView: MKMapView,
        viewFor annotation: MKAnnotation) -> MKAnnotationView?{
            
            if annotation is MyAnnotation == false{
                return nil
            }
            
            /* First typecast the annotation for which the Map View has
            fired this delegate message */
            let senderAnnotation = annotation as! MyAnnotation
            
            /* We will attempt to get a reusable
            identifier for the pin we are about to create */
            let pinReusableIdentifier = senderAnnotation.pinColor.rawValue
            
            /* Using the identifier we retrieved above, we will
            attempt to reuse a pin in the sender Map View */
            var annotationView =
            mapView.dequeueReusableAnnotationView(
                withIdentifier: pinReusableIdentifier) as? MKPinAnnotationView
            
            if annotationView == nil{
                /* If we fail to reuse a pin, then we will create one */
                annotationView = MKPinAnnotationView(annotation: senderAnnotation,
                    reuseIdentifier: pinReusableIdentifier)
                
                /* Make sure we can see the callouts on top of
                each pin in case we have assigned title and/or
                subtitle to each pin */
                annotationView!.canShowCallout = true
            }
            
            if senderAnnotation.pinColor == .Blue{
                let pinImage = UIImage(named:"BluePin")
                annotationView!.image = pinImage
            } else {
                annotationView!.pinColor = senderAnnotation.pinColor.toPinColor()
            }
            
            return annotationView
            
    }
    
    /* Set up the map and add it to our view */
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .standard
        mapView.frame = view.frame
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    /* Add the pin to the map and center the map around the pin */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addPinToMapView()
    }

}

