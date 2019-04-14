//
//  MapViewController.swift
//  Get Together
//
//  Created by Liam O'Toole on 4/11/19.
//  Copyright © 2019 Liam O'Toole. All rights reserved.
//

import UIKit
import Mapbox

class MapViewController: UIViewController, MGLMapViewDelegate {
    
    var location: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "mapbox://styles/mapbox/streets-v11")
        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
        
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        mapView.tintColor = .darkGray
        // Set the map view‘s delegate property.
        mapView.delegate = self
        // Enable heading tracking mode so that the arrow will appear.
        mapView.userTrackingMode = .followWithHeading
        // Enable the permanent heading indicator, which will appear when the tracking mode is not `.followWithHeading`.
        mapView.showsUserHeadingIndicator = true
        mapView.showsUserLocation = true
        //add map
        view.addSubview(mapView)
        
        //add button for adding events
        let button = UIButton(frame: CGRect(x: 300, y: 675, width: 100, height: 50))
        button.backgroundColor = .green
        button.setTitle("Add Event", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(button)
        
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        mapView.setCenter((mapView.userLocation?.coordinate)!, animated: false)
        location = mapView.userLocation?.coordinate
    }
    
    //call the add event function when button clicked
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        self.performSegue(withIdentifier: "AddEventSegue", sender: self)
    }
}
