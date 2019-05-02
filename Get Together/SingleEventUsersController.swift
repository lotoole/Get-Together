//
//  SingleEventUsersController.swift
//  Get Together
//
//  Created by Liam O'Toole on 4/30/19.
//  Copyright © 2019 Liam O'Toole. All rights reserved.
//

import UIKit
import Firebase
class SingleEventUsersController: UITableViewController {
    var userIndex = 0
    var users: Array<String> = []
    
    override func viewDidLoad() {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friend", for: indexPath)
        
        cell.textLabel?.text = users[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        friendsIndex = indexPath.row
        performSegue(withIdentifier: "SingleFriendSegue", sender: self)
    }
    
    @IBAction func BackToEvent(_ sender: UIButton) {
        self.performSegue(withIdentifier: "BackToSingleEvent", sender: UIButton.self)
    }
    

}
