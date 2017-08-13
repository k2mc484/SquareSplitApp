//
//  searchFriends.swift
//  SquareSplitGroup
//
//  Created by Toyosi Akinlade on 7/20/17.
//  Copyright © 2017 Toyosi Akinlade. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class searchFriends: UITableViewController, UISearchResultsUpdating {
    
    @IBOutlet var searchFriends: UITableView!
    var usersArray = [NSDictionary?]()
    var filteredUsers = [NSDictionary?]()
    var ref:DatabaseReference?
    var groupID  = [String]()
    var groupName = [String]()
    var userID = [NSDictionary]()
    
    @IBOutlet weak var groupNameField: UITextField!
    var databaseref = Database.database().reference()
    var uidref = Database.database().reference()
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        
        databaseref.child("Users").queryOrdered(byChild:"Username" ).observe(.childAdded, with: {(snapshot) in
            
            self.usersArray.append(snapshot.value as? NSDictionary)
            
            
            self.searchFriends.insertRows(at: [IndexPath(row:self.usersArray.count-1, section:0)], with: UITableViewRowAnimation.automatic)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        //User ID array
        uidref.child("Users").queryOrdered(byChild: "User id").observe(.childAdded, with: {(snapshot) in
            
            self.userID.append((snapshot.value as? NSDictionary)!)
            print(self.userID[0])
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive && searchController.searchBar.text != ""
        {
            return filteredUsers.count
        }
        
        return self.usersArray.count
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let user:NSDictionary?
        if searchController.isActive && searchController.searchBar.text != ""
        {
            user = filteredUsers[indexPath.row]
        }
        else
        {
            user = self.usersArray[indexPath.row]
        }
        cell.textLabel?.text = user?["Username"] as? String
        cell.detailTextLabel?.text = user?["handle"] as? String
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func cancel(_sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    func updateSearchResults(for searchController: UISearchController) {
        //update search results
        
        filterContent(searchText:self.searchController.searchBar.text!)
    }
    
    func filterContent(searchText:String)
    {
        self.filteredUsers = self.usersArray.filter{ user in
            
            let username = user!["Username"] as? String
            
            return(username?.lowercased().contains(searchText.lowercased()))!
        }
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user:NSDictionary?
        
        //Add checkmark in cell
        if  tableView.cellForRow(at: indexPath)?.accessoryType != UITableViewCellAccessoryType.none
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            user = self.usersArray[indexPath.row]
            if groupID.contains(user?["User ID"] as! String)
            {
                groupID = self.groupID.filter {$0 != user?["User ID"] as! String}
            }
            if groupName.contains(user?["Username"] as! String)
            {
                groupName = self.groupName.filter {$0 != user?["Username"] as! String}
            }
        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            user = self.usersArray[indexPath.row]
            
            groupID.append((user?["User ID"] as? String)!)
            groupName.append((user?["Username"] as? String)!)
            
            
        }
        
        
    }
    
    @IBAction func createGroup(_ sender: Any) {
        ref = Database.database().reference()
        let groupReference = self.ref?.child("Groups").childByAutoId()
        let values = ["Name": self.groupNameField.text, "Total": "0", "ID": groupReference?.key] as [String : Any]
        print(groupID.count)
        groupReference?.updateChildValues(values as Any as! [AnyHashable : Any] , withCompletionBlock: {
            (error, reference) in
            
            if error == nil
            {
                print("Good")
            }
            else
            {
                print(error.debugDescription)
            }
        })
        
        for index in 0...groupID.count-1
        {
            let userReference = groupReference?.child("Users").child(groupID[index])
            let userName = ["Name": groupName[index]]
            userReference?.updateChildValues(userName, withCompletionBlock: {
                (error, reference) in
                if error == nil
                {
                    print("Success")
                }
                
            })
        }
        for index in 0...groupID.count-1
        {
            let newref = self.ref?.child("Users").child(groupID[index]).child("Groups").child((groupReference?.key)!)
            newref?.updateChildValues(["Name": self.groupNameField.text as Any, "ID": groupReference?.key], withCompletionBlock: {
                (error, reference) in
                
                if error == nil
                {
                    print(groupReference?.key)
                }
                else
                {
                    print(error.debugDescription)
                }
                
        
            })
            //Sets debts and credits for all users in database to 0
            let balance = ["Debit": "0", "Credit": "0"]
            newref?.updateChildValues(balance, withCompletionBlock: {
                (error, reference) in
                
                if error == nil
                {
                    print("")
                }
                else
                {
                    print(error.debugDescription)
                }
                
            })

        }
        //performSegue(withIdentifier: "toGroup", sender: nil)
        
    }
}
