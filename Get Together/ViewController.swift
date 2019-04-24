//
//  ViewController.swift
//  Get Together
//
//  Created by Liam O'Toole on 3/24/19.
//  Copyright © 2019 Liam O'Toole. All rights reserved.
//

import UIKit
import Mapbox
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        Email.delegate = self
//        Password.delegate = self
//        Email.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
//        Password.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
//        
    }
    
    @IBAction func user(_ sender: Any) {
    
    }
  


    
    @IBAction func password(_ sender: Any) {
      

    }
    
    @IBAction func click(_ sender: UIButton) {
        print("hello")
        var email = "tao@gmail.com"
        var pass = "tao12"
        
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            
            //print("USER \(result!.user.email)")
            
            //print(result!.user)
            
            // ...
            if let error = error{
                print("error",error.localizedDescription)
                // Alert user
            }
            
            // Segway
        }
        
        print(Email.text)
        print(Password.text)

    }
    
}

