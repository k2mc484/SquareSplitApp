//
//  ContainerViewController.swift
//  SquareSplit
//
//  Created by Michael Hall on 7/31/17.
//  Copyright © 2017 Hall Enterprises. All rights reserved.
//

import UIKit


class ContainerViewController: UIViewController {
    
    var menuShowing = false
    
    @IBOutlet weak var sideBarLeading: NSLayoutConstraint!
    @IBOutlet weak var sideBarTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var groupsLeading: NSLayoutConstraint!
    @IBOutlet weak var groupsTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var homeLeading: NSLayoutConstraint!
    @IBOutlet weak var homeTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var navigationLeading: NSLayoutConstraint!
    @IBOutlet weak var navigationTrailing: NSLayoutConstraint!
   
    @IBOutlet weak var containerViewHome: UIView!
    @IBOutlet weak var containerViewGroups: UIView!
    @IBOutlet weak var containerViewSidebar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        //Function used to toggle the sidebar using constraint manipulation
        @IBAction func goToSidebar(_ sender: Any) {
       
            if(menuShowing){
                sideBarLeading.constant = -240
                sideBarTrailing.constant = 375
                
                groupsLeading.constant = 0
                groupsTrailing.constant = 0
                
                homeLeading.constant = 0
                homeTrailing.constant = 0
                
                navigationLeading.constant = 0
                navigationTrailing.constant = 0

            }
            else{
                sideBarLeading.constant = 0
                sideBarTrailing.constant = 135
                
                groupsLeading.constant = 240
                groupsTrailing.constant = -240
               
                homeLeading.constant = 240
                homeTrailing.constant = 240
                
                navigationLeading.constant = 240
                navigationTrailing.constant = -240
            }
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            menuShowing = !menuShowing
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
