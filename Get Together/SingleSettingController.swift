//
//  SingleSettingController.swift
//  Get Together
//
//  Created by Liam O'Toole on 4/28/19.
//  Copyright © 2019 Liam O'Toole. All rights reserved.
//

import UIKit
import Firebase

class SingleSettingController: UIViewController {
    
    override func viewDidLoad() {
        print("Liams single setting loaded")
    }
    
    @IBAction func LogOutButton(_ sender: UIButton) {
        
        let firebaseAuth = Auth.auth()
        do {
            print("signed out")
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        //@IBAction func goBackToOneButtonTapped(_ sender: Any) {
            self.performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
        //}
        
        
    }
    
    
}

