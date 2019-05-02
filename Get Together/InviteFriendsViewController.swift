//
//  InviteFriendsViewController.swift
//  Get Together
//
//  Created by Cam Weston on 5/1/19.
//  Copyright © 2019 Liam O'Toole. All rights reserved.
//

import Foundation
import UIKit
import Firebase
class InviteFriendsViewController: UITableViewController {
    var userIndex = 0
    var friends: Array<String> = ["Cam","Gabe"]
    var eventId : String! = ""
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath)
        
       
        cell.textLabel?.text = friends[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userIndex = indexPath.row
        var inviteMsg = "Invite sent to: " + friends[userIndex]
        let alertController = UIAlertController(title: "Invite Sent", message: inviteMsg, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
        inviteFriend(friendName: friends[userIndex])
    }
    
    func inviteFriend(friendName: String){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid as! String
        let userEmail = Auth.auth().currentUser?.email as! String
        let inviteKey = eventId + userID
        ref.child("Invites")
            .child(inviteKey)
            .setValue(["to":friendName,"from":userEmail,"event":eventId])
    }
    
    
    @IBAction func BackToSingleEvent(_ sender: UIButton) {
        self.performSegue(withIdentifier: "BackToSingleEvent", sender: UIButton.self)
    }
    
}
