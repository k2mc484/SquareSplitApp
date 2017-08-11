//
//  NameGroupViewController.swift
//  SquareSplit
//
//  Created by Michael Hall on 8/10/17.
//  Copyright © 2017 Hall Enterprises. All rights reserved.
//

import UIKit

class NameGroupViewController: UIViewController {
    
    
    @IBOutlet weak var NameField: UITextField!
    @IBAction func next(_ sender: Any) {
        if(NameField.text == ""){
            //Display alery message
            self.displayMyAlertMessage(userMessage: "Group Name is required");
            return;
        }
        else{
        let myVC = storyboard?.instantiateViewController(withIdentifier: "searchFriends") as! searchFriends
        myVC.groupNameField = NameField.text!
        navigationController?.pushViewController(myVC, animated: true)
        }
            
        
        
    }
    func displayMyAlertMessage(userMessage:String)
    {
        let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        
        myAlert.addAction(okAction);
        self.present(myAlert, animated:true , completion:nil);
    }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
