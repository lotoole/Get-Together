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
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = self.newName.text!
        changeRequest?.commitChanges { (error) in
            // ...
        }
    }
    
    @IBAction func updateEmail(_ sender: UIButton) {
        print(self.newEmail.text!)
        Auth.auth().currentUser?.updateEmail(to: self.newEmail.text!) { (error) in
            print("ERROROROROR",error)
            // ...
        }
        let current = Auth.auth().currentUser?.email
        print(current)
        //then update userprofiles in DB
        print("update email")

    }
    @IBAction func updatePassword(_ sender: UIButton) {
        print(self.newPassword.text!)
        Auth.auth().currentUser?.updatePassword(to: self.newPassword.text!) { (error) in
            // ...
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
