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

class ListofGroups: UITableViewController, UISearchResultsUpdating {
    
    
    @IBOutlet weak var listGroups: UITableView!
    var groupsArray = [NSDictionary?]()
    var filteredGroups = [NSDictionary?]()
    var ref:DatabaseReference?
    
    
    
    var databaseref = Database.database().reference().child("Users")
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        let CurrentUser = Auth.auth().currentUser
        databaseref.child((CurrentUser?.uid)!).child("Groups").queryOrdered(byChild: "Name").observe(.childAdded, with: {(snapshot) in
            
            self.groupsArray.append(snapshot.value as? NSDictionary)
            
            
            self.listGroups.insertRows(at: [IndexPath(row:self.groupsArray.count-1, section:0)], with: UITableViewRowAnimation.automatic)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        //Group ID array maybe
        /* uidref.child("Users").queryOrdered(byChild: "User id").observe(.childAdded, with: {(snapshot) in
         
         self.userID.append((snapshot.value as? NSDictionary)!)
         print(self.userID[0])
         
         
         }) { (error) in
         print(error.localizedDescription)
         }
         */
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
            return filteredGroups.count
        }
        
        return self.groupsArray.count
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let group:NSDictionary?
        if searchController.isActive && searchController.searchBar.text != ""
        {
            group = filteredGroups[indexPath.row]
        }
        else
        {
            group = self.groupsArray[indexPath.row]
        }
        cell.textLabel?.text = group?["Name"] as? String
        cell.detailTextLabel?.text = ""
        
        return cell
    }
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
        self.filteredGroups = self.groupsArray.filter{ group in
            
            let groupname = group!["Name"] as? String
            
            return(groupname?.lowercased().contains(searchText.lowercased()))!
        }
        
        tableView.reloadData()
    }
    var name = ""
    var groupId = ""
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group:NSDictionary?
        group = self.groupsArray[indexPath.row]
        
        name = (group?["Name"] as? String)!
        groupId = (group?["ID"] as? String)!
        
        
        performSegue(withIdentifier: "myGroup", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let groupController = navController.viewControllers.first as! group
        
        groupController.passedGroupName = name
        groupController.passedGroupID = groupId
    }
    
    
    
}



