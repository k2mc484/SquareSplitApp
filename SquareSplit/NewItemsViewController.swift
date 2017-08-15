//
//  NewItemsViewController.swift
//  SquareSplit
//
//  Created by Toyosi Akinlade on 8/14/17.
//  Copyright © 2017 Hall Enterprises. All rights reserved.
//

import UIKit

class NewItemsViewController: UIViewController {

    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var itemNameField: UITextField!
    @IBOutlet weak var itemPriceField: UITextField!
    
    @IBAction func datWay(_ sender: Any) {
        performSegue(withIdentifier: "backToGroupPage", sender: nil)
    }
    var currentGroupName = String()
    var currentGroupID = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let groupController = segue.destination as! group
        
        groupController.passedGroupName = currentGroupName
        groupController.passedGroupID = currentGroupID
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
