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
    var isAttending = false
    var friendsInvite: Array<String> = []
    var friendsInviteId: Array<String> = []
   
    @IBOutlet weak var TitleOutlet: UILabel!
    @IBOutlet weak var AddressOutlet: UILabel!
    @IBOutlet weak var DescriptionOutlet: UILabel!
    @IBOutlet weak var TimeOutlet: UILabel!
    @IBOutlet weak var HostedByOutlet: UITextView!
    @IBOutlet weak var JoinButton: UIButton!
    
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
        updateAttendanceList{updateButtonOnAttendanceFinish()}
        requestFriendsListData()
    }
    
    func renderSingleEventView(event: Event) {
        //set all the outlet variables text to the event objects information
        TitleOutlet.text = event.title
        AddressOutlet.text = event.address
        TimeOutlet.text = event.time
        HostedByOutlet.text = event.createdBy
        DescriptionOutlet.text = event.description
    }


    @IBAction func ViewUsersSegue(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ViewUsersSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seuc = segue.destination as? SingleEventUsersController {
            seuc.users = self.eventUsersList
        }
        if let ifvc = segue.destination as? InviteFriendsViewController {
            ifvc.eventId = self.eventId
        }
        if let ifc = segue.destination as? InviteFriendsViewController {
            ifc.friends = friendsInvite
            ifc.friendsId = friendsInviteId
        }
    }
    
    
    
    @IBAction func BackToMap(_ sender: UIButton) {
        self.performSegue(withIdentifier: "BackToMap", sender: self)
    }
    
    @IBAction func JoinButtonPressed(_ sender: Any) {
        print("Join Button Pressed")
        //When the button is pressed check if they clicked it when it said join or unjoin by checking if they are attending
        
        //If the user is attending than remove the user because they just unjoined
        if(isAttending){
            
            //Set button to unjoin
            //Is attending = true
            userUnjoin{updateAttendanceList{updateButtonOnAttendanceFinish()}}
        }
            //If the user is not attending than add the user to the event attendance
        else{
            //Set button to join
            //Is attending = false
            userJoin{updateAttendanceList{updateButtonOnAttendanceFinish()}}
        }
    }
    
    func updateButtonOnAttendanceFinish(){
        updateJoinButton()
    }
    
    func updateAttendanceList(completion: (() -> Void)) {
        print ("Update Attendence List")
        var ref: DatabaseReference!
        let userEmail = Auth.auth().currentUser?.email as! String
        ref = Database.database().reference()
        ref.child("EventAttendence").child(eventId!).observeSingleEvent(of: .value, with: {
            (snapshot) in
            if let valueDict = snapshot.value as? NSDictionary {
                for(_, value) in valueDict {
                    let value = value as! String
                    self.eventUsersList.append(value)
                    if(value.elementsEqual(userEmail)){
                        self.isAttending = true
                        self.updateJoinButton()
                    }
                }
            }
            
        })
        print("New attendance list ---->" ,self.eventUsersList)
        completion() //on complete run update button
    }
    
    func updateJoinButton(){
        print("Update Join Button")
        //If the user is currently attending
        if(isAttending){
            //Set the button to say unjoin and isAttending to true
            setButtonToUnjoin()
        }
        else{
            //Set the button to say join and isAttending to false
            setButtonToJoin()
        }
    }
    
    func userJoin(completion: (() -> Void)){
        print("User Join")
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid as! String
        let userEmail = Auth.auth().currentUser?.email as! String
        ref.child("EventAttendence")
            .child(eventId!)
            .child(userID)
            .setValue(userEmail)
        self.isAttending=true
        completion() //On user join complete run update attendance
    }
    
    
    func userUnjoin(completion: (() -> Void)){
        print("User Unjoin")
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid as! String
        ref.child("EventAttendence")
            .child(eventId!)
            .child(userID)
            .removeValue()
        self.isAttending=false
        completion() //On user unjoin complete run update attendance and update button
    }
    
    func setButtonToJoin(){
        print("Set button to join")
        //Set button to green and title to "Join"
        JoinButton.backgroundColor = UIColor.green
        JoinButton.setTitle("Join",for: .normal)
        //Set isAttending to false
        isAttending = false
    }
    
    func setButtonToUnjoin(){
        print("Set button to unjoin")
        //Set button to orange and title to "Unjoin"
        JoinButton.backgroundColor = UIColor.orange
        JoinButton.setTitle("Unjoin",for: .normal)
        //Set isAttending to true
        isAttending = true
    }
    
    
    @IBAction func InviteFriendsSegue(_ sender: Any) {
        self.performSegue(withIdentifier: "InviteFriendsSegue", sender: self)
    }
    
    @IBAction func BackToSingleEvent(segue: UIStoryboardSegue) {}
    
    
    func requestFriendsListData() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid as! String
        ref.child("UserFriends")
            .child(userID)
            .observeSingleEvent(of: .value, with:{
                (snapshot) in
                
                print("Snap Children",snapshot.hasChildren())
                if let valueDict = snapshot.value as? NSDictionary {
                    for(key, value) in valueDict {
                        let single = valueDict[key] as? NSDictionary
                        for(key, value) in single! {
                            //append the key and value to the two arrays
                            self.friendsInvite.append(value as! String)
                            self.friendsInviteId.append(key as! String)
                        }
                    }
                }
            }){
                (error) in
                print(error.localizedDescription)
        }
    }
    
}
