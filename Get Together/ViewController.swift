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
        print(EmailSignUp.isEmpty)
        if(!(EmailSignUp.isEmpty && PasswordSignUp.isEmpty)) {
            return
        }
        
        auth.auth().createUser(withEmail: EmailSignUp, password: PasswordSignUp) {
            authResult, error in
            
            if let error = error {
                print("error",error.localizedDescription)
                return
            } else {
                print("This is good")
                
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
        print(Email.text)
        print(Password.text)

    }
    
}

