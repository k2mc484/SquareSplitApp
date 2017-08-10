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
        let myVC = storyboard?.instantiateViewController(withIdentifier: "searchFriends") as! searchFriends
        myVC.groupNameField = NameField.text!
        navigationController?.pushViewController(myVC, animated: true)
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
