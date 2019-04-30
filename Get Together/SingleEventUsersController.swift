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
        //add button for adding events
        let button = UIButton(frame: CGRect(x: 300, y: 10, width: 80, height: 25))
        button.backgroundColor = .green
        button.setTitle("Back", for: .normal)
        button.addTarget(self, action: #selector(returnToEvent), for: .touchUpInside)
        view.addSubview(button)
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
    }
    
    //call the add event function when button clicked
    @IBAction func returnToEvent(_ sender: UIButton!) {
        self.performSegue(withIdentifier: "ReturnToEventSegue", sender: self)
    }

}
