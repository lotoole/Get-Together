//
//  SingleEventController.swift
//  Get Together
//
//  Created by Liam O'Toole on 4/29/19.
//  Copyright © 2019 Liam O'Toole. All rights reserved.
//

import UIKit
import Firebase
class SingleEventController: UIViewController {
    var eventId: String!
   
    @IBOutlet weak var TitleOutlet: UILabel!
    @IBOutlet weak var AddressOutlet: UILabel!
    @IBOutlet weak var DescriptionOutlet: UILabel!
    @IBOutlet weak var TimeOutlet: UILabel!
    @IBOutlet weak var HostedByOutlet: UITextView!
    
    
    
    override func viewDidLoad() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("Events").child(eventId!).observeSingleEvent(of: .value, with: {
            (snapshot) in
            let valueDict = snapshot.value as? NSDictionary
            
            
            let event: NSObject = valueDict! as NSObject
            let title: String = event.value(forKey:"title")! as! String
            let longitude: Double = event.value(forKey:"longitude")! as! Double
            let latitude: Double = event.value(forKey:"latitude")! as! Double
            let address: String = event.value(forKey:"address")! as! String
            let createdBy: String = event.value(forKey:"createdBy")! as! String
            let time: String = event.value(forKey:"time")! as! String
            print("Event title",title)
            print(snapshot.valueInExportFormat())
        })
        print("Liams", eventId!)
        
    }
    
    func renderSingleEventView(event: Event) {
        //set all the outlet variables text to the event objects information
        TitleOutlet.text = event.title
        AddressOutlet.text = event.address
    }
    
    @IBAction func ViewAttendance(_ sender: UIButton) {

        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("EventAttendence").child(eventId!).observeSingleEvent(of: .value, with: {
            (snapshot) in
            let valueDict = snapshot.value as? NSDictionary
            print("dict",valueDict!)
            
            let event: NSObject = valueDict! as NSObject
            print("event!",event)
            
            //GET EMAIL
        })
        
    }
    @IBAction func joinEvent(_ sender: UIButton) {
        print("JOINED")
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        
        let userID = Auth.auth().currentUser?.uid as! String
        let userEmail = Auth.auth().currentUser?.email as! String
        print("USER ID HERE!",userID)
        print("PRINT", eventId!)
        
//    ref.child("UserProfile").child(userID).observeSingleEvent(of: .value, with: {
//            (snapshot) in
//        print("SHOULD BE EMAIL",snapshot.value(forKey: userID))
//
//        })
//
        ref.child("EventAttendence")
            .child(eventId!)
            .child(userID)
            .setValue(userEmail)
    
    }
}
