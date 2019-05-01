//
//  FriendsViewController.swift
//  Get Together
//
//  Created by Liam O'Toole on 4/28/19.
//  Copyright © 2019 Liam O'Toole. All rights reserved.
//

import UIKit
import Firebase
//TO DO: Make this array be information coming from the database, and populate the stack using it
//this array will be of settings objects from the database
var friendsArray = ["hi","hello"]
var friendsIndex = 0
class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
   @IBOutlet weak var SearchFriends: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func AddFriend(_ sender: UIButton) {
        
     
        let userId = Auth.auth().currentUser?.uid as! String
        let userEmail = Auth.auth().currentUser?.email as! String
     
       
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("UserFriends").child(userId).childByAutoId().setValue(SearchFriends.text!)
       
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = friendsArray[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        friendsIndex = indexPath.row
       
    }
    //------------------------------------------------------------------
    
}
