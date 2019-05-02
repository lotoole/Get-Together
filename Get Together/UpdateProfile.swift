//
//  UpdateProfile.swift
//  Get Together
//
//  Created by 贪van蓝月 on 2019/5/1.
//  Copyright © 2019 Liam O'Toole. All rights reserved.
//
import UIKit
import Firebase

class UpdateProfile: UIViewController {
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var newName: UITextField!
    @IBOutlet weak var newEmail: UITextField!
    
    @IBOutlet weak var newPassword: UITextField!
    
    
    
    @IBAction func BackToSettings(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SettingsCancel", sender: self)
    }
    

    @IBAction func updateName(_ sender: UIButton) {
        print(self.newName.text!)
        print("update name")
        
        if(self.newName.text!.isEmpty) {
            
            //display error to user
            let alertController = UIAlertController(title: "Error", message: "You did not enter a name", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = self.newName.text!
        changeRequest?.commitChanges { (error) in
            if let error = error {
                print("User input error",error.localizedDescription)
                //display error to user
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                return
            }
        }
    }
    
    @IBAction func updateEmail(_ sender: UIButton) {
        print(self.newEmail.text!)
        if(self.newEmail.text!.isEmpty) {
            //display error to user
            let alertController = UIAlertController(title: "Error", message: "You did not enter an email", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        Auth.auth().currentUser?.updateEmail(to: self.newEmail.text!) { (error) in
            if let error = error{
                print("User input error",error.localizedDescription)
                //display error to user
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
        let current = Auth.auth().currentUser?.email
        print(current)
        //then update userprofiles in DB
        print("update email")

    }
    @IBAction func updatePassword(_ sender: UIButton) {
        print(self.newPassword.text!)
        if(self.newPassword.text!.isEmpty) {
            //display error to user
            let alertController = UIAlertController(title: "Error", message: "You did not enter a password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        Auth.auth().currentUser?.updatePassword(to: self.newPassword.text!) { (error) in
            if let error = error{
                print("User input error",error.localizedDescription)
                //display error to user
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }

        print("update password")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn1.layer.cornerRadius = 10
        btn2.layer.cornerRadius = 10
        btn3.layer.cornerRadius = 10
    }
    
}
