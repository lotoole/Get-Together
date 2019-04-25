//
//  AddEventController.swift
//  Get Together
//
//  Created by Liam O'Toole on 4/24/19.
//  Copyright © 2019 Liam O'Toole. All rights reserved.
//

import UIKit
import MapboxGeocoder
class AddEventController: UIViewController {
    
    var coordinate:CLLocationCoordinate2D!
    let geocoder = Geocoder(accessToken: "pk.eyJ1IjoiZ2V0dG9nZXRoZXIiLCJhIjoiY2p0ZWpydWwxMWl1ajN6b2FhYnJmcGV3aSJ9.sYvTy3su2cTOvT94kax_qQ")

    
   
    override func viewDidLoad() {
        //if the user pressed the add event button
        if(coordinate == nil){
         print("Add event button pressed")
        }
        //if the user pressed down on the map to add event
        else{
            print("Tap down. Coordinates : " , coordinate)
        }
        
        super.viewDidLoad()
        }
}

