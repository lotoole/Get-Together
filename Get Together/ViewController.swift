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
    
    @IBOutlet weak var EmailSignUp: UITextField!
    
    @IBOutlet weak var PasswordSignUp: UITextField!
    
    @IBAction func OnChangeSignUpEmail(_ sender: Any) {
    }
    
    @IBAction func OnChangeSignUpPassword(_ sender: Any) {
    }
    
    
    @IBAction func RegisterUser(_ sender: UIButton) {
        print("REGISTER")
        print(self.EmailSignUp.text!)
        print(self.PasswordSignUp.text!)
        print(EmailSignUp.text!.isEmpty)
        print(PasswordSignUp.text!.isEmpty)
        if(EmailSignUp.text!.isEmpty || PasswordSignUp.text!.isEmpty) {
            print("what is this")
            return
        }

        Auth.auth().createUser(withEmail: self.EmailSignUp.text!, password: self.PasswordSignUp.text!) {
            authResult, error in
            let uid = authResult!.user.uid as String
            print("GetUID",uid)
            if let error = error {
                print("error",error.localizedDescription)
                return
            } else {
                print("This is good")
                // Segue
            }
        }

    }
    
    @IBAction func BackToSignIn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "navigatetosignin", sender: nil)
    
    }
    
    
    @IBAction func SignUpButton(_ sender: UIButton) {
        print("hello world")
        self.performSegue(withIdentifier: "navigatetosignup", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    @IBAction func user(_ sender: Any) {
    
    }
  


    
    @IBAction func password(_ sender: Any) {
      

    }
    
    @IBAction func click(_ sender: UIButton) {
        if(self.Email.text!.isEmpty || self.Password.text!.isEmpty) {
            print("Incorrect input")
            return
        }
        Auth.auth().signIn(withEmail: self.Email.text!, password: self.Password.text!) { [weak self] user, error in
            if let error = error {
                print("error",error.localizedDescription)
                return
            } 
            print(user!)
            guard let strongSelf = self else { return }
            
            // ...
            
        }
        
    }
    
}

