//
//  GroupsTableViewController.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController, UISearchBarDelegate {
  
  var groupsArray: [Groups] = []
  var filteredGroupsArray: [Groups] = []
  var searchActive = false
  
    
    @IBAction func logOutGroups(_ sender: Any) {
    }
    @IBOutlet var groupsTableView: UITableView!
  @IBOutlet weak var groupsSearchBar: UISearchBar!
  

    override func viewDidLoad() {
        super.viewDidLoad()
        getUserGroups()
        filteredGroupsArray = groupsArray
        groupsTableView.keyboardDismissMode = .onDrag
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroupsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let avatarName = filteredGroupsArray[indexPath.row].avatarPath
      let avatarImage = UIImage(named: avatarName)
      let groupsName = filteredGroupsArray[indexPath.row].name
      let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupsListCell
      cell.groupsAvatar.image = avatarImage
      cell.groupsName.text = groupsName
      return cell
    }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
          groupsArray.remove(at: indexPath.row)
          updateUserGroupsOnServer()
          //syncronize filteredGroupsArray with the server
          updateFilteredUserGroups()
          tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
  
  //MARK: searchBar
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchActive = true
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    hideKeyboard()
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
   
    filteredGroupsArray = groupsArray.filter({ (group) -> Bool in
      FirstLetterSearch.isMatched(searchBase: group.name, searchString: searchText)
    })
    
    if (searchText.count == 0) {
    
      updateFilteredUserGroups()
      searchActive = false
      hideKeyboard()
    }
    groupsTableView.reloadData()
  }
  
  @objc func hideKeyboard() {
    searchActive = false
    groupsSearchBar.endEditing(true)
  }

  
  //MARK: Prepare tableView datasource
  func getUserGroups() {
    if let userId = StorageContent.getUserId() {
      groupsArray = Content.getUserGroups(userId: userId) ?? []
    }
  }
  
  func updateUserGroupsOnServer() {
    if let userId = StorageContent.getUserId() {
      Content.updateUserGroups(userId: userId, updatedGroupsArray: groupsArray)
    }
  }
  
  func updateFilteredUserGroups(){
    getUserGroups()
    filteredGroupsArray = groupsArray
  }
  
  //MARK: Navigation
  @IBAction func addGroup(segue: UIStoryboardSegue) {
    if segue.identifier == "addGroup" {
      let allGroupsTableViewController = segue.source as! AllGroupsTableViewController
      if  let groupToAddIndexPath = allGroupsTableViewController.availableGroupsTableView.indexPathForSelectedRow {
        let groupToAdd = allGroupsTableViewController.filteredAvailableGroupsArray[groupToAddIndexPath.row]
        if !groupsArray.contains(groupToAdd) {
          groupsArray.append(groupToAdd)
          updateUserGroupsOnServer()
          updateFilteredUserGroups()
          groupsTableView.reloadData()
        }
      }
    }
  }
}
