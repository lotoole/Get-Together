//
//  SettingsViewController.swift
//  Get Together
//
//  Created by Kyle Michel on 4/14/19.
//  Copyright © 2019 Liam O'Toole. All rights reserved.
//

import UIKit

//this array will be of settings objects from the database
var settings = ["Anonomous", "Tesing"]
var myIndex = 0
class SettingsViewController2: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = settings[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "SingleSettingSegue", sender: self)
    }
    //------------------------------------------------------------------
    
}
