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
    // TRY CATCH HERE FOR NO INPUT
    print(email.isEmpty)
    if((email.isEmpty || password.isEmpty)){
        print("true")
        return
    }
    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
    
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
    print(email.isEmpty)
    if(!(email.isEmpty && password.isEmpty)){
        print("true")
        return
    }
         //  Create a reference to the database
    Auth.auth().createUser(withEmail: email, password: password){
        authResult, error in
        
        if let error = error{
            print("error",error.localizedDescription)
            // Alert user
            
            
            //            self.alert(title:"Error", message: error.localizedDescription)
            return
            
            // Structure in DB from below command
            // Post to database tabel registeredEmails
            // Unique ID = "email@gmail.com"
            //ref.child("registeredEmails").childByAutoId().setValue(self.Email.text!)
            
        }else{
            print("this is good")
        }
        
    }
}
