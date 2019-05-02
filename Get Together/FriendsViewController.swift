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
    var friendsArrayName = [String]()
    var friendsIndex = 0
   @IBOutlet weak var SearchFriends: UISearchBar!
    
 
    
    @IBOutlet weak var taboutlet: UITableView!
    //----------------------------------------------------------
    
    
    //------------------------------------------------------------
    override func viewDidLoad() {
  
    }
    override func viewWillAppear(_ animated: Bool) {
        getFriends()
        print(friendsArrayName)
    }
    
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
            let friendUID: String
            print(valueDict)
            do{
                friendUID = try valueDict!.value(forKey: parsedUsername) as! String
            }
            catch{
                print("error")
                return
            }
            //friendsArray.append()
            for (key,_) in valueDict! {
                
                let contact:NSObject = valueDict![key] as! NSObject
            }
            ref.child("UserFriends")
            .child(userId)
            .childByAutoId()
            .setValue([friendUID:parsedUsername])

        }){
            (error) in
            print("error ",error.localizedDescription)
        }
        self.getFriends()
        
       
    }
    
    func getFriends() {
        let userId = Auth.auth().currentUser?.uid as! String
        let userEmail = Auth.auth().currentUser?.email as! String
        
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("UserFriends").child(userId).observeSingleEvent(of: .value, with:{
            (snapshot) in
            if(snapshot.hasChildren()){
                if let valueDict = snapshot.value as? NSDictionary{
                    for (key,value) in valueDict {
                        
                        let profile = value as? NSDictionary
                        for (key,value) in profile! {

                            if(!self.friendsArrayName.contains(value as! String)){
                                self.friendsArrayName.append(value as! String)
                                self.friendsArrayId.append(key as! String)
                            }
                            
                            
                        }
                    }
                    DispatchQueue.main.async {
                        print("async",self.friendsArrayName)

                        self.taboutlet.reloadData()
                    }
                }
            }
            
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.friendsArrayName.count <= 0{
            return 0
        }

        return self.friendsArrayName.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //cell.textLabel?.text = friendsArrayName[indexPath.row]
        cell.textLabel?.text = friendsArrayName[indexPath.row]
        print("loading view",self.friendsArrayName.count)
//        if(self.friendsArrayName.count<=0){
//            print("checkfriends is 0")
//            self.getFriends{self.printme()}
//        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        friendsIndex = indexPath.row
       
    }
    //------------------------------------------------------------------

}
