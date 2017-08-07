//
//  ViewController.swift
//  CustomEmailLogin
//
//  Created by Christopher Ching on 2017-01-31.
//  Copyright © 2017 Christopher Ching. All rights reserved.
//

import UIKit
import FirebaseAuth


class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func displayMyAlertMessage(userMessage:String)
    {
        let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        
        myAlert.addAction(okAction);
        self.present(myAlert, animated:true , completion:nil);
    }
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        // TODO: Do some form validation on the email and password
        if let email = emailTextField.text, let pass = passwordTextField.text {
            
            // Sign in the user with Firebase
            Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                
                // Check that user isn't nil
                if user != nil {
                    // User is found, go to home screen
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                }
                else {
                    // Error: check error and show message
                    //Check for empty fields
                    if(email == "" || pass == ""){
                        
                        //Display alery message
                        self.displayMyAlertMessage(userMessage: "All fields are required");
                        return;
                    }
                    else{
                        //Error, check error
                        
                        self.displayMyAlertMessage(userMessage: "Username or Password is incorrect");
                        return;
                    }
                    
                }
                
            }
            
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Dismiss the keyboard when the view is tapped on
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    
}
