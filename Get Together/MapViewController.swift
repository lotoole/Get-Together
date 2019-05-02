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
    var eventList : Array<Event> = []
    var eventId: String!
    var invitesList : Array<String> = []
    var inviteEventIdList: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DID LOAD")
        generateMapView()
        addCreateEventButton()
        addViewInvitesButton()
        getAllEvents()
        getInvites()


    }
    override func viewDidAppear(_ animated: Bool){
//        super.viewWillAppear(animated)
        print("DID APPEAR")

        renderMapEvents(events : self.eventList)
    }
    
    func getInvites(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        print("USER ID HERE!",userID)
        //var invites = Array<Invite> = []
        ref.child("Invites").observeSingleEvent(of: .value, with:{
            (snapshot) in
            let valueDict = snapshot.value as? NSDictionary
            if(snapshot.hasChildren()){
                
                
                for(key, _) in valueDict! {
                    let invite:NSObject = valueDict![key] as! NSObject
                    //only add to arrays if you have been invited to an event, if no invites print that
                    if(invite.value(forKey: "to") as? String == userID){
                        let to = invite.value(forKey: "to")
                        let inviteEventSingleId = invite.value(forKey: "event")
                        self.inviteEventIdList.append(inviteEventSingleId as! String)
                        self.invitesList.append(to as! String)
                        print(inviteEventSingleId)
                    }
                }
            }
        }){
            (error) in
            print(error.localizedDescription)
        }
    }

    func getAllEvents(){
        print("Getting all events")
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        print("USER ID HERE!",userID)
        ref.child("Events").observeSingleEvent(of: .value, with:{
            (snapshot) in
            
            print("Snap Children",snapshot.hasChildren())
            let valueDict = snapshot.value as? NSDictionary
            
            //NSUInteger count = [valueDict! count]
            
            if(snapshot.hasChildren()){
                
            
            for(key, _) in valueDict! {
                let event: NSObject = valueDict![key] as! NSObject
                let title: String = event.value(forKey:"title")! as! String
                let longitude: Double = event.value(forKey:"longitude")! as! Double
                let latitude: Double = event.value(forKey:"latitude")! as! Double
                let address: String = event.value(forKey:"address")! as! String
                let createdBy: String = event.value(forKey:"createdBy")! as! String
                let time: String = event.value(forKey:"time")! as! String
                let description: String = event.value(forKey: "description")! as! String
                let eventDTO = Event(
                 id: "12knd2",
                 title: title,
                 longitude:  longitude,
                 latitude: latitude,
                 address: address,
                 createdBy: createdBy,
                 time: time,
                 description: description
                )
                 self.eventList.append(eventDTO)
                
            }
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
    func addViewInvitesButton() {
        //add button for adding events
        let viewInvitesButton = UIButton(frame: CGRect(x: 15, y: 675, width: 100, height: 50))
        viewInvitesButton.backgroundColor = .green
        viewInvitesButton.setTitle("View Invites", for: .normal)
        viewInvitesButton.addTarget(self, action: #selector(addViewInvitesClicked), for: .touchUpInside)
        view.addSubview(viewInvitesButton)
    }
    //call the add event function when button clicked
    @objc func addViewInvitesClicked(_ sender: UIButton!) {
        self.performSegue(withIdentifier: "ViewInvitesSegue", sender: self)
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
    
    func renderMapEvents(events: Array<Event>){
        for event in events{
            let eventAnnotation=MGLPointAnnotation()
            eventAnnotation.coordinate=CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude)
            eventAnnotation.title=event.title
            mapView.addAnnotation(eventAnnotation)
        }
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        //change this to annotation.subtitle once we start querying events by id instead of title
        eventId = annotation.title as? String
        self.performSegue(withIdentifier: "SingleEventTransfer", sender: self)
        return false
    }
    
    //call the add event function when button clicked
    @objc func buttonAction(_ sender: UIButton!) {
        self.performSegue(withIdentifier: "AddEventSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sec = segue.destination as? SingleEventController {
            sec.eventId = eventId
        }
        if let aec = segue.destination as? AddEventController {
            aec.userLocation = mapView.userLocation?.coordinate
        }
        if let itv = segue.destination as? InvitesTableViewController {
            itv.inviteArray = invitesList
            itv.inviteEventIds = inviteEventIdList
        }
    }
    
    //get user location once the map is fully loaded
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        //mapView.setCenter((mapView.userLocation?.coordinate)!, animated: false)
        location = mapView.userLocation?.coordinate
    }
    
    @IBAction func BackToMap(segue: UIStoryboardSegue) {}
    
   
}
