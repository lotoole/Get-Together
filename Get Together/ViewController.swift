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
        var email = "tao@gmail.com"
        var pass = "tao123"
        
        Auth.auth().signIn(withEmail: email, password: pass) { [weak self] user, error in
            print(user!)
            guard let strongSelf = self else { return }
            
            // ...
            
        }
        print(self!.Email.text!)
        print(self!.Password.text!)

    }
    
}

