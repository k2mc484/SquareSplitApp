//
//  PasswordResetViewController.swift
//  SquareSplit
//
//  Created by Michael Hall on 7/16/17.
//  Copyright © 2017 Hall Enterprises. All rights reserved.
//

import UIKit
import FirebaseAuth

class PasswordResetViewController: UIViewController {
    @IBOutlet weak var emailTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func displayMyAlertMessage(userMessage:String)
    {
        let myAlert = UIAlertController(title:"Email Sent!", message:userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        
        myAlert.addAction(okAction);
        self.present(myAlert, animated:true , completion:nil);
    }
    
    
    
    @IBAction func passwordResetButtonTapped(_ sender: Any) {
        
        if let email = emailTextfield.text{
            //Alert telling user that an email has been sent
            self.displayMyAlertMessage(userMessage: "Please check email to reset pasword!");
            
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            }
        }
    }
}

