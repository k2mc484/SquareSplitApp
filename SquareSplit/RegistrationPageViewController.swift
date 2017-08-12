//
//  RegistrationViewController.swift
//  SquareSplit
//
//  Created by Michael Hall on 7/16/17.
//  Copyright © 2017 Hall Enterprises. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegistrationPageViewController: UIViewController
{
    var ref: DatabaseReference!
    @IBOutlet weak var repeatPasswordTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var firstTextfield: UITextField!
    @IBOutlet weak var lastTextfield: UITextField!
    
    var balance = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
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
    
    
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        if let email = emailTextfield.text, let pass = passwordTextfield.text, let username = usernameTextfield.text, let passRepeat = repeatPasswordTextfield.text, let first = firstTextfield.text, let last = lastTextfield.text {
            Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                
                // Check that user isn't nil
                if user != nil {
                    // User is found, go to home screen
                    let userID: String = user!.uid
                    let userEmail:String = self.emailTextfield.text!
                    let userPassword:String = self.passwordTextfield.text!
                    let userUsername:String = self.usernameTextfield.text!
                    let userFirst:String = self.firstTextfield.text!
                    let userLast:String = self.lastTextfield.text!
                    //Send user information to the database
                    self.ref.child("Users").child(userID).setValue(["Email":userEmail,"Password": userPassword,"Username":userUsername, "User ID": userID, "First":userFirst,"Last":userLast, "Balance":self.balance]);
                    //Go back to login page
                    if user != nil {
                        // User is found, go to home screen
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    // Send verifiation email
                    Auth.auth().currentUser?.sendEmailVerification { (error) in
                    }
       
                }
                    // Error: check error and show message

                else {
                    //Check for empty fields
                    if(email == "" || pass == "" || username == "" || passRepeat == "" || first == "" || last == "" ){
                        
                        //Display alery message
                        self.displayMyAlertMessage(userMessage: "All fields are required");
                        return;
                    }
                    
                    //Check if passwords match
                    if(pass != passRepeat){
                        //Display alery message
                        self.displayMyAlertMessage(userMessage: "Passwords do not match");
                        return;
                    }
                    if(pass.characters.count<6){
                        //Display alery message
                        self.displayMyAlertMessage(userMessage: "Password must be 6 characters long");
                        return;
                    }
                    else{
                        //Display alery message
                        self.displayMyAlertMessage(userMessage: "Email must be a valid email");
                        return;
                    }
                }
                
                
                
            }
            
        }
    }
    // Dismiss the keyboard when the view is tapped on
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextfield.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
    }
    
    
}

