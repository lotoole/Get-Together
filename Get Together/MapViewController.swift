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
import Firebase
class MapViewController: UIViewController, MGLMapViewDelegate {
    var mapView: MGLMapView!
    var location: CLLocationCoordinate2D!
    var mapConstraints: MGLCoordinateBounds!
    var coordinatesNewEvent:CLLocationCoordinate2D!
    var fakeEvents : Array<Event> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        generateMapView()
        addCreateEventButton()
        getAllEvents()
        addFakeEvents()
        for item in self.fakeEvents{
            print("Fake items ",item)
        }
        renderMapEvents(events : self.fakeEvents)
    
    }
    func getAllEvents(){
        print("Getting all events")
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        print("USER ID HERE!",userID)
        ref.child("Events").observeSingleEvent(of: .value, with:{
            (snapshot) in
            let valueDict = snapshot.value as? NSDictionary

            for(key, val) in valueDict! {
                let event: NSObject = valueDict![key] as! NSObject
                let title: String = event.value(forKey:"title")! as! String
                let longitude: Double = event.value(forKey:"longitude")! as! Double
                let latitude: Double = event.value(forKey:"latitude")! as! Double
                let address: String = event.value(forKey:"address")! as! String
                let createdBy: String = event.value(forKey:"createdBy")! as! String
//                print(x)
                print(latitude)
                var eventDTO = Event(
                 id: "12knd2",
                 title: title,
                 longitude:  longitude,
                 latitude: latitude,
                 address: address,
                 createdBy: createdBy
                )
                print("Event working",eventDTO.latitude)
                 self.fakeEvents.append(eventDTO)
            }
            }){
            (error) in
            print(error.localizedDescription)
        }
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
    //TODO: REMOVE THIS ONCE WE CAN POPULATE FROM DB
    func addFakeEvents() -> Void{
        //fake event 1
        var fakeEvent1 = Event(id: "12knd2", title: "Funeral for my GPA", longitude:  -73.198474, latitude: 44.480138, address: "Perkins Hall, Burlington, VT 05405", createdBy: "Cam")
        //fake event 2
         var fakeEvent2 = Event(id: "1h5hj2", title: "Press F to pay respects",longitude:  -73.198389, latitude: 44.480878, address: "8 Mansfield Ave, Burlington, VT 05401", createdBy: "Cam")
        //fake event 3
         var fakeEvent3 = Event(id: "5h2jh5", title: "Tao's Dinner", longitude: -73.199692, latitude: 44.480197, address: "University Pl, Burlington, VT 05405", createdBy: "Cam")
        
        self.fakeEvents.append(fakeEvent1)
        self.fakeEvents.append(fakeEvent2)
        self.fakeEvents.append(fakeEvent3)

//        return fakeEvents
    }
    
    func renderMapEvents(events: Array<Event>){
        for event in events{
            let eventAnnotation=MGLPointAnnotation()
            eventAnnotation.coordinate=CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude)
            eventAnnotation.title=event.title
            mapView.addAnnotation(eventAnnotation)
        }
    }
    
   
    
    //call the add event function when button clicked
    @objc func buttonAction(_ sender: UIButton!) {
        self.performSegue(withIdentifier: "AddEventSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let aec = segue.destination as? AddEventController {
            aec.eventCoordinate = coordinatesNewEvent
        }
    }
    
    //get user location once the map is fully loaded
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        //mapView.setCenter((mapView.userLocation?.coordinate)!, animated: false)
        location = mapView.userLocation?.coordinate
    }
    
   
}
