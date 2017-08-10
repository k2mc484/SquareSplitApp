//
//  HomeScreenViewController.swift
//  SquareSplit
//
//  Created by Michael Hall on 7/19/17.
//  Copyright © 2017 Hall Enterprises. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class HomeScreenViewController: UIViewController {
    //Sidebar button functionality 
    
    
    //Needed to update username on main page

    var ref: DatabaseReference!
    var refHandle: UInt!
   
    
    //For menu toggle
    var menuShowing = false
  
    
    //For display of user info
    @IBOutlet weak var UsernameLabel: UILabel!
    
    //Toggle the menu screen
    override func viewDidLoad() {
        
            super.viewDidLoad()
        
        //Update username, first, and last on main page
        ref = Database.database().reference()
        refHandle = ref.observe(DataEventType.value, with: { (snapshot) in
            let detaDict = snapshot.value as! [String:AnyObject]
            print(detaDict)
        })
        let userID: String = (Auth.auth().currentUser?.uid)!
        
       
            //Display user info
            ref.child("Users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                
                let value = snapshot.value as? NSDictionary
                let last = value?["Last"] as? String ?? ""
                let first = value?["First"] as? String ?? ""
                


                self.UsernameLabel.text = "Welcome, " + first + " " + last
            })
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
