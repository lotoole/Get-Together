//
//  FriendsViewController.swift
//  Get Together
//
//  Created by Liam O'Toole on 4/28/19.
//  Copyright © 2019 Liam O'Toole. All rights reserved.
//

import UIKit
//TO DO: Make this array be information coming from the database, and populate the stack using it
//this array will be of settings objects from the database
var friendsArray = ["Anonomous", "Tesing"]
var friendsIndex = 0
class FriendsViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = friendsArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        friendsIndex = indexPath.row
        performSegue(withIdentifier: "SingleFriendSegue", sender: self)
    }
    //------------------------------------------------------------------
    
}
