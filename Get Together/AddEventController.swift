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
    
    let geocoder = Geocoder(accessToken: "pk.eyJ1IjoiZ2V0dG9nZXRoZXIiLCJhIjoiY2p0ZWpydWwxMWl1ajN6b2FhYnJmcGV3aSJ9.sYvTy3su2cTOvT94kax_qQ")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let options = ForwardGeocodeOptions(query: "200 queen street")
        
        // To refine the search, you can set various properties on the options object.
        options.allowedISOCountryCodes = ["CA"]
        options.focalLocation = CLLocation(latitude: 45.3, longitude: -66.1)
        options.allowedScopes = [.address, .pointOfInterest]
        
        let task = geocoder.geocode(options) { (placemarks, attribution, error) in
            guard let placemark = placemarks?.first else {
                return
            }
            
            print(placemark.name)
            // 200 Queen St
            print(placemark.qualifiedName)
            // 200 Queen St, Saint John, New Brunswick E2L 2X1, Canada
            
            let coordinate = placemark.location?.coordinate
            print("Liams line below")
            print("\(coordinate?.latitude), \(coordinate?.longitude)")
            // 45.270093, -66.050985
            
            #if !os(tvOS)
            let formatter = CNPostalAddressFormatter()
            print(formatter.string(from: placemark.postalAddress!))
            // 200 Queen St
            // Saint John New Brunswick E2L 2X1
            // Canada
            #endif
        }
    }
}
