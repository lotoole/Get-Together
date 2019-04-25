//
//  MapViewController.swift
//  Get Together
//
//  Created by Liam O'Toole on 4/11/19.
//  Copyright © 2019 Liam O'Toole. All rights reserved.
//
import UIKit
import Mapbox
import MapboxGeocoder
class MapViewController: UIViewController, MGLMapViewDelegate {
    var mapView: MGLMapView!
    var location: CLLocationCoordinate2D!
    var mapConstraints: MGLCoordinateBounds!
    var coordinatesNewEvent:CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateMapView()
        addGesturesToMap()
        addCreateEventButton()
    }
    func addCreateEventButton(){
        //add button for adding events
        let button = UIButton(frame: CGRect(x: 300, y: 675, width: 100, height: 50))
        button.backgroundColor = .green
        button.setTitle("Add Event", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(button)
    }
    func generateMapView(){
        let url = URL(string: "mapbox://styles/mapbox/streets-v11")
        mapView = MGLMapView(frame: view.bounds, styleURL: url)
        //add map
        view.addSubview(mapView)
        
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        mapView.tintColor = .darkGray
        // Set the map view‘s delegate property.
        mapView.delegate = self
        // Enable heading tracking mode so that the arrow will appear.
        mapView.userTrackingMode = .followWithHeading
        // Enable the permanent heading indicator, which will appear when the tracking mode is not `.followWithHeading`.
        mapView.showsUserHeadingIndicator = true
        mapView.showsUserLocation = true
        
        
    
    }
    func addGesturesToMap(){
        // Gesture for add event on long press
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
        mapView.addGestureRecognizer(longPress)
    }
    
    @objc func didLongPress(_ sender: UILongPressGestureRecognizer) {
        guard sender.state == .began else { return }
        // Converts point where user did a long press to map coordinates
        let point = sender.location(in: mapView)
        coordinatesNewEvent = mapView.convert(point, toCoordinateFrom: mapView)
        
        //AddEvent Segue
        self.performSegue(withIdentifier: "AddEventSegue", sender: self)
    }
    
    //call the add event function when button clicked
    @objc func buttonAction(_ sender: UIButton!) {
        self.performSegue(withIdentifier: "AddEventSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let aec = segue.destination as? AddEventController {
            aec.coordinate = coordinatesNewEvent
        }
    }
    
    //get user location once the map is fully loaded
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        //mapView.setCenter((mapView.userLocation?.coordinate)!, animated: false)
        location = mapView.userLocation?.coordinate
    }
    
   
}
