//
//  group.swift
//  SquareSplitGroup
//
//  Created by Toyosi Akinlade on 7/20/17.
//  Copyright © 2017 Toyosi Akinlade. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class group: UIViewController {
    
    @IBOutlet weak var personalTotal: UILabel!
    @IBOutlet weak var eventTotal: UILabel!
    @IBOutlet weak var groupName: UILabel!
    var ref: DatabaseReference!
    var passedGroupName = String()
    var passedGroupID = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        groupName.text = passedGroupName
        ref = Database.database().reference()
        let userID: String = (Auth.auth().currentUser?.uid)!
        
        ref.child("Users").child(userID).child("Groups").child(passedGroupID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let debit = value?["Debit"] as? String
            let credit = value?["Credit"] as? String
            //FINISH THIS --> let name = value?["Name"] as? String
            
            let personalTotalDoub = Double(debit!)! - Double(credit!)!
            
            self.personalTotal.text = "$" + String(personalTotalDoub)
            
            // Circles
            self.personalTotal.layer.cornerRadius = 50
            self.personalTotal.layer.borderWidth = 2
            self.personalTotal.layer.borderColor = UIColor.blue.cgColor
            self.personalTotal.layer.bounds = CGRect(x: 208, y: 100, width: 100, height: 100)
            
            self.eventTotal.layer.cornerRadius = 50
            self.eventTotal.layer.borderWidth = 2
            self.eventTotal.layer.borderColor = UIColor.red.cgColor
            self.eventTotal.layer.bounds = CGRect(x: 0, y: 100, width: 100, height: 100)
            
        })
        ref.child("Groups").child(passedGroupID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let total = value?["Total"] as? String
            self.eventTotal.text = "$"+total!
            
            
        })
        
    }
    
    // Do any additional setup after loading the view.
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func toNewItem(_ sender: Any) {
        performSegue(withIdentifier: "toNewItem", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewItem"
        {
            let itemController = segue.destination as! NewItemsViewController
            
            itemController.currentGroupName = passedGroupName
            itemController.currentGroupID = passedGroupID
        }
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
