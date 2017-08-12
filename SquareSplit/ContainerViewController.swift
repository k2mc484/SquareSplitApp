//
//  ContainerViewController.swift
//  SquareSplit
//
//  Created by Michael Hall on 7/31/17.
//  Copyright © 2017 Hall Enterprises. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import GoogleSignIn
import FirebaseDatabase

class ContainerViewController: UIViewController {
    
    var ref: DatabaseReference!
    var refHandle: UInt!
    
    @IBOutlet weak var firstSidebarLabel: UILabel!
    @IBOutlet weak var lastSidebarLabel: UILabel!
    @IBOutlet weak var usernameSidebarLabel: UILabel!

    var menuShowing = false
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    
    @IBOutlet weak var sideBarTrailing: NSLayoutConstraint!
    @IBOutlet weak var sideBarLeading: NSLayoutConstraint!
   
    @IBOutlet weak var groupsLeading: NSLayoutConstraint!
    @IBOutlet weak var groupsTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var homeLeading: NSLayoutConstraint!
    @IBOutlet weak var homeTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var navigationLeading: NSLayoutConstraint!
    @IBOutlet weak var navigationTrailing: NSLayoutConstraint!
   
    @IBOutlet weak var containerViewHome: UIView!
    @IBOutlet weak var containerViewGroups: UIView!
    
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
            self.firstSidebarLabel.text = first + " " + last
            
        })
    }
    
    //Segue to building a group
    @IBAction func goToGroupBuilder(_ sender: Any){
        self.performSegue(withIdentifier: "goToGroupBuilder", sender: self)
    }
    
    //Segment controller for switching views
    @IBAction func showComponent(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.containerViewHome.alpha = 1
                self.containerViewGroups.alpha = 0
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.containerViewHome.alpha = 0
                self.containerViewGroups.alpha = 1
            })
        }
    }

        //Function used to toggle the sidebar using constraint manipulation
        @IBAction func goToSidebar(_ sender: Any) {
       
            if(menuShowing){
                sideBarLeading.constant = -240
                sideBarTrailing.constant = 0
                
                groupsLeading.constant = 0
                groupsTrailing.constant = 0
                
                homeLeading.constant = 0
                homeTrailing.constant = 0
                
                navigationLeading.constant = 0
                navigationTrailing.constant = 0

            }
            else{
                sideBarLeading.constant = 0
                sideBarTrailing.constant = 0
                
                
                groupsLeading.constant = 240
                groupsTrailing.constant = -240
               
                homeLeading.constant = 240
                homeTrailing.constant = -240
                
                navigationLeading.constant = 240
                navigationTrailing.constant = -240
                }
            UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            })
            menuShowing = !menuShowing
    }
    
    
    @IBAction func sidebarHome(_ sender: Any) {
        sideBarLeading.constant = -240
        sideBarTrailing.constant = 0
        
        groupsLeading.constant = 0
        groupsTrailing.constant = 0
        
        homeLeading.constant = 0
        homeTrailing.constant = 0
        
        navigationLeading.constant = 0
        navigationTrailing.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        menuShowing = !menuShowing
        
        self.containerViewHome.alpha = 1
        self.containerViewGroups.alpha = 0
        
        segmentController.selectedSegmentIndex = 0;

    }
   

    
    @IBAction func sidebarGroups(_ sender: Any) {
        sideBarLeading.constant = -240
        sideBarTrailing.constant = 0
        
        groupsLeading.constant = 0
        groupsTrailing.constant = 0
        
        homeLeading.constant = 0
        homeTrailing.constant = 0
        
        navigationLeading.constant = 0
        navigationTrailing.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        menuShowing = !menuShowing
        
        self.containerViewHome.alpha = 0
        self.containerViewGroups.alpha = 1
        
        segmentController.selectedSegmentIndex = 1;
        
    }
    @IBAction func sidebarNewGroup(_ sender: Any) {
        sideBarLeading.constant = -240
        sideBarTrailing.constant = 0
        
        groupsLeading.constant = 0
        groupsTrailing.constant = 0
        
        homeLeading.constant = 0
        homeTrailing.constant = 0
        
        navigationLeading.constant = 0
        navigationTrailing.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        menuShowing = !menuShowing
        self.performSegue(withIdentifier: "goToGroupBuilder", sender: self);

    }
    
    @IBAction func sidebarInviteFriends(_ sender: Any) {
        sideBarLeading.constant = -240
        sideBarTrailing.constant = 0
        
        groupsLeading.constant = 0
        groupsTrailing.constant = 0
        
        homeLeading.constant = 0
        homeTrailing.constant = 0
        
        navigationLeading.constant = 0
        navigationTrailing.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        menuShowing = !menuShowing
    }
    @IBAction func sidebarHelp(_ sender: Any) {
        sideBarLeading.constant = -240
        sideBarTrailing.constant = 0
        
        groupsLeading.constant = 0
        groupsTrailing.constant = 0
        
        homeLeading.constant = 0
        homeTrailing.constant = 0
        
        navigationLeading.constant = 0
        navigationTrailing.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        menuShowing = !menuShowing
    }
    @IBAction func sidebarSettings(_ sender: Any) {
        sideBarLeading.constant = -240
        sideBarTrailing.constant = 0
        
        groupsLeading.constant = 0
        groupsTrailing.constant = 0
        
        homeLeading.constant = 0
        homeTrailing.constant = 0
        
        navigationLeading.constant = 0
        navigationTrailing.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        menuShowing = !menuShowing
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
