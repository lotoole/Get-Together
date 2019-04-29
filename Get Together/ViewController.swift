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
  

    @IBAction func backToSignUp(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SignInToSignUp", sender: nil)
    }
    
    
    @IBAction func password(_ sender: Any) {
      

    }
    
    @IBAction func SignUp(_ sender: UIButton) {
        print("CLICKED SIGN UP")
        self.performSegue(withIdentifier: "SignUpSegue", sender: nil)
    }
    
    @IBAction func SubmitSignUp(_ sender: Any) {
        print("clicked Submit sign up")
        createAccount(email: self.Email.text!,password: self.Password.text!)
        self.performSegue(withIdentifier: "logInSegue", sender: nil)
        }
    
    @IBAction func click(_ sender: UIButton) {
        //try catch
        LogIn(email: self.Email.text!,password: self.Password.text!)
        // Login successful, navigate
        
          self.performSegue(withIdentifier: "logInSegue", sender: nil)
            
    }

}
