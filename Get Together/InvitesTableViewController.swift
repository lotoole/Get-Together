//
//  InvitesTabeViewController.swift
//  Get Together
//
//  Created by Liam O'Toole on 5/1/19.
//  Copyright © 2019 Liam O'Toole. All rights reserved.
//
import UIKit

var inviteArray = ["Log out", "Testing"]
var inviteIndex = 0
var inviteEventId = ""

class InvitesTableViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inviteArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "invite", for: indexPath)
        
        cell.textLabel?.text = inviteArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        inviteIndex = indexPath.row
        performSegue(withIdentifier: "ViewEventFromInvite", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sec = segue.destination as? SingleEventController {
            sec.eventId = inviteEventId
        }
    }
    
    
    @IBAction func BackToMap(_ sender: UIButton) {
        self.performSegue(withIdentifier: "BackToMapFromInvites", sender: self)
    }
}
