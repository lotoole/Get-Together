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
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    
    @IBAction func CreateAccountSegue(_ sender: Any) {
        if(EmailSignUp.text!.isEmpty || PasswordSignUp.text!.isEmpty) {
            print("what is this")
            //display error to user
            let alertController = UIAlertController(title: "Error", message: "You did not enter an email or password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        Auth.auth().createUser(withEmail: self.EmailSignUp.text!, password: self.PasswordSignUp.text!) {
            authResult, error in
            if let error = error {
                print("User input error",error.localizedDescription)
                //display error to user
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                return
            } else {
                print("should segue to map")
                var ref: DatabaseReference!
                ref = Database.database().reference()
                var username = self.EmailSignUp.text! as! String
                let atSymbolIndex = username.index(of: "@")
                let parsedUsername = username.substring(to: atSymbolIndex!)
                
                ref.child("UserProfiles")
                .child(parsedUsername)
                    .setValue([parsedUsername:authResult?.user.uid])
                
                
                self.performSegue(withIdentifier: "SignUpSegue", sender: UIViewController.self)
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
            //display error to user
            let alertController = UIAlertController(title: "Error", message: "You did not enter an email or password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            return
        }

        else{
            Auth.auth().signIn(withEmail: self.Email.text!, password: self.Password.text!) { [weak self] user, error in
                if let error = error {
                    print("error",error.localizedDescription)
                    //display error to user
                    let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self?.present(alertController, animated: true, completion: nil)
                    return
                } else {
                    self?.performSegue(withIdentifier: "LogInSuccessSegue", sender: self)
                }
                print(user!)
                guard let strongSelf = self else { return }
            }

        }
    }
    
}

