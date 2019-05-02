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
class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var dumbyArray = ["hey","hello","yo"]
    var friendsArrayId = [""]
    var friendsArrayName = [""]
    var friendsIndex = 0
   @IBOutlet weak var SearchFriends: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    //----------------------------------------------------------
    
    
    //------------------------------------------------------------
   
    
    @IBAction func AddFriend(_ sender: UIButton) {
     
        let userId = Auth.auth().currentUser?.uid as! String
        let userEmail = Auth.auth().currentUser?.email as! String
        var ref: DatabaseReference!
        ref = Database.database().reference()
        var username = self.SearchFriends.text! as! String
        let atSymbolIndex = username.index(of: "@")
        let parsedUsername = username.substring(to: atSymbolIndex!).lowercased()
        
        
        ref.child("UserProfiles").child(parsedUsername).observeSingleEvent(of: .value, with:{
            (snapshot) in
            let valueDict = snapshot.value as? NSDictionary
            var friendUID = valueDict!.value(forKey: parsedUsername) as! String
            print(friendUID)
            //friendsArray.append()
            for (key,_) in valueDict! {
                
                let contact:NSObject = valueDict![key] as! NSObject
                print(contact)
                print(key)
            }
            ref.child("UserFriends")
            .child(userId)
            .childByAutoId()
            .setValue([friendUID:parsedUsername])

        }){
            (error) in
            print("error ",error.localizedDescription)
        }
        
       
    }
    override func viewDidLoad() {

//        getFriends{print("DONT")}
//        print(friendsArrayName)
    }
    override func viewWillAppear(_ animated: Bool) {
//         self.reloadInputViews()
        getFriends{printme()}
        print(friendsArrayName)
    }
    func printme(){
        print("DONE")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dumbyArray.count
        //return friendsArrayName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //cell.textLabel?.text = friendsArrayName[indexPath.row]
        cell.textLabel?.text = dumbyArray[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        friendsIndex = indexPath.row
       
    }
    //------------------------------------------------------------------
 
    func getFriends(completion: (()->Void)) {
        
        let userId = Auth.auth().currentUser?.uid as! String
        let userEmail = Auth.auth().currentUser?.email as! String
        
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
    
        ref.child("UserFriends").child(userId).observeSingleEvent(of: .value, with:{
            (snapshot) in
            if let valueDict = snapshot.value as? NSDictionary{
            for (key,value) in valueDict {
                self.friendsArrayName.append(value as! String)
                self.friendsArrayId.append(key as! String)
                print(key)
                print(value)
            }
                print(self.friendsArrayName)
            
            }

        })
        completion()
    }
}
