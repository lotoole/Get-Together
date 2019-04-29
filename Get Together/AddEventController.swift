//
//  AddEventController.swift
//  Get Together
//
//  Created by Liam O'Toole on 4/24/19.
//  Copyright © 2019 Liam O'Toole. All rights reserved.
//

import UIKit
import MapboxGeocoder
import Firebase
class AddEventController: UIViewController {
    
    let geocoder = Geocoder(accessToken: "pk.eyJ1IjoiZ2V0dG9nZXRoZXIiLCJhIjoiY2p0ZWpydWwxMWl1ajN6b2FhYnJmcGV3aSJ9.sYvTy3su2cTOvT94kax_qQ")
    var eventTitle = ""
    var eventAddress = ""
    var eventTime = ""
    var eventDescription = ""
    var eventCoordinate:CLLocationCoordinate2D!
    
    @IBOutlet weak var TitleOutlet: UITextField!
    @IBOutlet weak var AddressOutlet: UITextField!
    @IBOutlet weak var TimeOutlet: UITextField!
    @IBOutlet weak var DescriptionOutlet: UITextField!

    
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        }
    
    //submit button, should add event to database if it passes
    @IBAction func submitAddEvent(_ sender: Any) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
            //forward geocode the users input to get cordinates to submit
            let userAddressInput = ForwardGeocodeOptions(query: AddressOutlet.text!)
            //refine the search
            userAddressInput.allowedScopes = [.address, .pointOfInterest]
            let task = geocoder.geocode(userAddressInput) { (placemarks, attribution, error) in
                guard let placemark = placemarks?.first else {
                    return
                }
                print("Forward geocoding result")
                print(placemark.name)
                print(placemark.qualifiedName)
                let coordinate = placemark.location?.coordinate
                print("\(coordinate?.latitude), \(coordinate?.longitude)")
                //set all the string variables from what is in the form
                self.eventTitle += self.TitleOutlet.text!
                self.eventAddress += placemark.qualifiedName!
                self.eventTime += self.TimeOutlet.text!
                self.eventDescription += self.DescriptionOutlet.text!
                self.eventCoordinate = placemark.location?.coordinate
                //POST data to an event the user has

                //Missing ID and CreatedBY
                ref.child("Events")
                    .child(self.eventTitle)
                    .setValue([
                        "title":self.eventTitle,
                        "longitude":self.eventCoordinate.longitude,
                        "latitude":self.eventCoordinate.latitude,
                        "address":self.eventAddress,
                        "description":self.eventDescription,
                        "createdBy":"UPDATE"
                        ])
            }
    }
    
    
}

