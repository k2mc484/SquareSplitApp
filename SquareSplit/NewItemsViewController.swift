//
//  NewItemsViewController.swift
//  SquareSplit
//
//  Created by Toyosi Akinlade on 8/14/17.
//  Copyright © 2017 Hall Enterprises. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class NewItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var itemNameField: UITextField!
    @IBOutlet weak var itemPriceField: UITextField!
    
    @IBAction func datWay(_ sender: Any) {
        performSegue(withIdentifier: "backToGroupPage", sender: nil)
    }
    var currentGroupName = String()
    var currentGroupID = String()
    var namesArray = [NSDictionary?]()
    var databaseref:DatabaseReference?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseref = Database.database().reference()
       let groupRef = databaseref?.child("Groups")
        groupRef?.child(currentGroupID).child("Users").queryOrdered(byChild: "Name").observe(.childAdded, with: {(snapshot) in
            
            self.namesArray.append(snapshot.value as? NSDictionary)
            print("HERE")
            print(self.namesArray.count)
            
            
            self.usersTableView.insertRows(at: [IndexPath(row:self.namesArray.count-1, section:0)], with: UITableViewRowAnimation.automatic)
            
        }) { (error) in
            print(error.localizedDescription)
            
        }

        // Do any additional setup after loading the view.
    }
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        return self.namesArray.count
        
        
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let group:NSDictionary?
        
        
            group = self.namesArray[indexPath.row]
        
        cell.textLabel?.text = group?["Name"] as? String
        cell.detailTextLabel?.text = ""
        
        return cell
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
