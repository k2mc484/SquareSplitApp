//
//  BuildGroupContainer.swift
//  SquareSplit
//
//  Created by Michael Hall on 8/9/17.
//  Copyright © 2017 Hall Enterprises. All rights reserved.
//

import UIKit

class BuildGroupContainer: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var groupNameField: UITextField!

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
