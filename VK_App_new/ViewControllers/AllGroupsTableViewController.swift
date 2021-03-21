//
//  AllGroupsTableViewController.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import UIKit

class AllGroupsTableViewController: UITableViewController, UISearchBarDelegate {
  
  var availableGroupsArray: [Groups] = []
  var filteredAvailableGroupsArray: [Groups] = []
  
  @IBOutlet var availableGroupsTableView: UITableView!
  @IBOutlet weak var allGroupsSearchBar: UISearchBar!
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
        getAvailableGroups()
        filteredAvailableGroupsArray = availableGroupsArray
        availableGroupsTableView.keyboardDismissMode = .onDrag
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAvailableGroupsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let avatarName = filteredAvailableGroupsArray[indexPath.row].avatarPath
      let avatarImage = UIImage(named: avatarName)
      let groupsName = filteredAvailableGroupsArray[indexPath.row].name
      let cell = tableView.dequeueReusableCell(withIdentifier: "availableGroupsCell", for: indexPath) as! GroupsListCell
      cell.groupsAvatar.image = avatarImage
      cell.groupsName.text = groupsName
      return cell
    }
  
  //MARK: searchBar
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    hideKeyboard()
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //keep only names matching searchBar input
    filteredAvailableGroupsArray = availableGroupsArray.filter({ (group) -> Bool in
      FirstLetterSearch.isMatched(searchBase: group.name, searchString: searchText)
    })
    
    if (searchText.count == 0) {
      //restore initial state of data received from server
      restoreAvailableGroups()
      hideKeyboard()
    }
    availableGroupsTableView.reloadData()
  }
  
  @objc func hideKeyboard() {
    allGroupsSearchBar.endEditing(true)
  }


  func getAvailableGroups() {
    availableGroupsArray = Content.getAvailableGroups() ?? []
  }
  
  func restoreAvailableGroups(){
    getAvailableGroups()
    filteredAvailableGroupsArray = availableGroupsArray
  }
}
