//
//  sideBarViewController.swift
//  SquareSplit
//
//  Created by Michael Hall on 8/2/17.
//  Copyright © 2017 Hall Enterprises. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase



class sideBarViewController: UIViewController {
    
    var ref: DatabaseReference!
    var refHandle: UInt!
    
    @IBOutlet weak var firstSidebarLabel: UILabel!
    @IBOutlet weak var lastSidebarLabel: UILabel!
    @IBOutlet weak var usernameSidebarLabel: UILabel!
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
        //Update username, first, and last on sidebar
        ref = Database.database().reference()
        refHandle = ref.observe(DataEventType.value, with: { (snapshot) in
            let detaDict = snapshot.value as! [String:AnyObject]
            print(detaDict)
        })
        let userID: String = (Auth.auth().currentUser?.uid)!
        
        
        //Display user info
        ref.child("Users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let username = value?["Username"] as? String ?? ""
            let first = value?["First"] as? String ?? ""
            let last = value?["Last"] as? String ?? ""
            
            
            self.usernameSidebarLabel.text = username
            self.firstSidebarLabel.text = first
            self.lastSidebarLabel.text = last
            
        })
    }
    

    @IBAction func logoutButtonTapped(_ sender: Any) {
        
        //Logout the user
        if Auth.auth().currentUser != nil{
            let firebaseAuth = Auth.auth()
            do{
                try firebaseAuth.signOut();
            }
            catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
        //Segue back to the Login screen
        self.performSegue(withIdentifier: "goToLogin", sender: self);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
