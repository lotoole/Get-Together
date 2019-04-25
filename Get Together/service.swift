//
//  service.swift
//  Get Together
//
//  Created by Gabriel Aboy on 4/25/19.
//  Copyright © 2019 Liam O'Toole. All rights reserved.
//

import Foundation
import Firebase

func LogIn(email: String, password: String) -> Void{
    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
       // print("hello ",result!.user.email)
        // If user doesnt exist
        if let error = error{
            print("error",error.localizedDescription)
            // Alert user
            
            
            //            self.alert(title:"Error", message: error.localizedDescription)
            return
            
            // Structure in DB from below command
            // Post to database tabel registeredEmails
            // Unique ID = "email@gmail.com"
            //ref.child("registeredEmails").childByAutoId().setValue(self.Email.text!)
            
        }
        else{
            print("OKAY")
            
        }
//        isAuthenticated = true
    }
    
    // Check if user is true or false
//    return await isAuthenticated
//    return isAuthenticated
}


func createAccount(email: String, password: String) -> Void {
    
         //  Create a reference to the database
    var ref: DatabaseReference!
    ref = Database.database().reference()
    // Create a new account
    Auth.auth().createUser(withEmail: email, password: password)
    {
        (result, error) in
        if let error = error{
            print("error creating", error.localizedDescription)
        }
    }
}
