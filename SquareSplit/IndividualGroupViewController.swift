//
//  group.swift
//  SquareSplitGroup
//
//  Created by Toyosi Akinlade on 7/20/17.
//  Copyright © 2017 Toyosi Akinlade. All rights reserved.
//

import UIKit
import FirebaseAuth

class group: UIViewController {
    
    @IBOutlet weak var groupName: UILabel!
    var passedGroupName = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        groupName.text = passedGroupName
        
        }
        
        // Do any additional setup after loading the view.
    
    @IBAction func back(_ sender: Any) {
        performSegue(withIdentifier: "backToGroups", sender: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //to id should be an array
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
