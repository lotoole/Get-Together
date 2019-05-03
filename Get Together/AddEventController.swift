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
    var userLocation:CLLocationCoordinate2D!
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
                    //display error to user if address input is empty
                    let alertController = UIAlertController(title: "Error", message: "There is an error with your address input, please try again", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                print("Forward geocoding result")
                print(placemark.qualifiedName)
                var coordinate = placemark.location?.coordinate
                print("\(coordinate?.latitude), \(coordinate?.longitude)")
                //set all the string variables from what is in the form
                self.eventTitle = self.TitleOutlet.text!
                self.eventAddress = placemark.qualifiedName!
                self.eventTime = self.TimeOutlet.text!
                self.eventDescription = self.DescriptionOutlet.text!
                self.eventCoordinate = placemark.location?.coordinate
                //POST data to an event the user has
                let userID = Auth.auth().currentUser?.uid as! String
                let userEmail = Auth.auth().currentUser?.email as! String
                //check for errors with user input
                print("Rel score", placemark.relevance)
                if(self.distance(lat1: (coordinate?.latitude)!, lon1: (coordinate?.longitude)!, lat2: self.userLocation.latitude, lon2: self.userLocation.longitude, unit: "M") > 5) {
                    //display error to user
                    let alertController = UIAlertController(title: "Error", message: "Addresses must be within 5 miles, please be more specific with your address input", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                } else if(self.AddressOutlet.text!.isEmpty || self.TitleOutlet.text!.isEmpty || self.TimeOutlet.text!.isEmpty) {
                    print("what is this")
                    //display error to user
                    let alertController = UIAlertController(title: "Error", message: "You left 1 or more reqiured fields empty", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                else {
                    //Missing ID and CreatedBY
                    ref.child("Events")
                        .child(self.eventTitle)
                        .setValue([
                            "title":self.eventTitle,
                            "longitude":self.eventCoordinate.longitude,
                            "latitude":self.eventCoordinate.latitude,
                            "address":self.eventAddress,
                            "description":self.eventDescription,
                            "time":self.eventTime,
                            "createdBy":userEmail
                            ])
                    self.performSegue(withIdentifier: "EventAddedSegue", sender: UIButton.self)
                }
        }
    }
    func deg2rad(deg:Double) -> Double {
        return deg * .pi / 180
    }
    func rad2deg(rad:Double) -> Double {
        return rad * 180.0 / .pi
    }
    func distance(lat1:Double, lon1:Double, lat2:Double, lon2:Double, unit:String) -> Double {
        let theta = lon1 - lon2
        var dist = sin(deg2rad(deg: lat1)) * sin(deg2rad(deg: lat2)) + cos(deg2rad(deg: lat1)) * cos(deg2rad(deg: lat2)) * cos(deg2rad(deg: theta))
        dist = acos(dist)
        dist = rad2deg(rad: dist)
        dist = dist * 60 * 1.1515
        if (unit == "K"){
            dist = dist * 1.609344
        }
    else if (unit == "N"){
            dist = dist * 0.8684
        }
        return dist
    }
}

