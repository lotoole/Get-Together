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
    var currentEvent: Event!
    var eventUsersList: Array<String> = []
   
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
            let description: String = event.value(forKey:"description")! as! String
            
            //set global event variable to current events information
            self.currentEvent = Event(
                id: "12knd2",
                title: title,
                longitude:  longitude,
                latitude: latitude,
                address: address,
                createdBy: createdBy,
                time: time,
                description: description
            )
            //pass the event to our render function to update the information in the UI View
            self.renderSingleEventView(event: self.currentEvent)
            print("Event title",title)
            print(snapshot.valueInExportFormat())
        })
        //get list for users going to this event
        ref.child("EventAttendence").child(eventId!).observeSingleEvent(of: .value, with: {
            (snapshot) in
            if let valueDict = snapshot.value as? NSDictionary {
                for(_, value) in valueDict {
                    self.eventUsersList.append(value as! String)
                }
            }
            
        })
        print("Liams", eventId!)
    }
    
    func renderSingleEventView(event: Event) {
        //set all the outlet variables text to the event objects information
        TitleOutlet.text = event.title
        AddressOutlet.text = event.address
        TimeOutlet.text = event.time
        HostedByOutlet.text = event.createdBy
        DescriptionOutlet.text = event.description
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
    @IBAction func ViewUsersSegue(_ sender: Any) {
        self.performSegue(withIdentifier: "ViewUsersSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seuc = segue.destination as? SingleEventUsersController {
            seuc.users = self.eventUsersList
        }
    }
    
    
}
