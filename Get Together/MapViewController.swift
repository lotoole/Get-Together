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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "mapbox://styles/mapbox/streets-v11")
        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 59.31, longitude: 18.06), zoomLevel: 9, animated: false)
        mapView.tintColor = .darkGray
        
        //        Get User Location
        
        
        //        set bounds based on user location
        //        let bounds = MGLCoordinateBounds(
        //            sw: CLLocationCoordinate2D(latitude: 43.7115, longitude: 10.3725),
        //            ne: CLLocationCoordinate2D(latitude: 43.7318, longitude: 10.4222))
        //        mapView.setVisibleCoordinateBounds(bounds, animated: false)
        
        //add map
        view.addSubview(mapView)
        //add button for adding events
        let button = UIButton(frame: CGRect(x: 300, y: 675, width: 100, height: 50))
        button.backgroundColor = .green
        button.setTitle("Add Event", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(button)
        
        // Set the map view‘s delegate property.
        mapView.delegate = self
        
    }
    //call the add event function when button clicked
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        self.performSegue(withIdentifier: "AddEventSegue", sender: self)
    }

    
}
