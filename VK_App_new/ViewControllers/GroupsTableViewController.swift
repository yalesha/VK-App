//
//  GroupsTableViewController.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController, UISearchBarDelegate {
  
  var groupsArray = [Group]()
  var filteredGroupsArray: [Group] = []
  var searchActive = false
    
    private let networkSession = NetworkService(token: Session.shared.token)
  
    
    @IBAction func logOutGroups(_ sender: Any) {
    }
    @IBOutlet var groupsTableView: UITableView!
  @IBOutlet weak var groupsSearchBar: UISearchBar!
  

    var sectionedGroups: [GroupSection] {
        groupsArray.reduce(into: []) {
            currentSectionGroup, group in
            guard let firstLetter = group.name.first else { return }
            
            if let currentSectionGroupFirstLetterIndex = currentSectionGroup.firstIndex(where: { $0.title == firstLetter }) {
                
                let oldSection = currentSectionGroup[currentSectionGroupFirstLetterIndex]
                let updatedSection = GroupSection(title: firstLetter, groups: oldSection.groups + [group])
                currentSectionGroup[currentSectionGroupFirstLetterIndex] = updatedSection
                
            } else {
                let newSection = GroupSection(title: firstLetter, groups: [group])
                currentSectionGroup.append(newSection)
            }
        }.sorted()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(GroupHeader.self, forHeaderFooterViewReuseIdentifier: GroupHeader.reuseIdentifier)
//        getUserGroups()
//        filteredGroupsArray = groupsArray
//        groupsTableView.keyboardDismissMode = .onDrag
    }
    override func viewWillAppear(_ animated: Bool) {
        networkSession.loadGroups(completionHandler: { [weak self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(groups):
                self?.groupsArray = groups
                self?.tableView.reloadData()
            }
        })
//        NetworkService.loadGroupSearch(token: String)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionedGroups.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: GroupHeader.reuseIdentifier) as? GroupHeader else { return nil }
        
        let firstLetter = String(sectionedGroups[section].title)
        header.headerTitle.text = firstLetter
        
        return header
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionedGroups[section].groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//      let avatarName = filteredGroupsArray[indexPath.row].avatarPath
//      let avatarImage = UIImage(named: avatarName)
//      let groupsName = filteredGroupsArray[indexPath.row].name
      let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupsListCell
//      cell.groupsAvatar.image = avatarImage
//      cell.groupsName.text = groupsName
//
        cell.configureGroup(with: sectionedGroups[indexPath.section].groups[indexPath.row])
        tableView.separatorStyle = .singleLine
        return cell
    }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
          groupsArray.remove(at: indexPath.row)
//          updateUserGroupsOnServer()
          //syncronize filteredGroupsArray with the server
//          updateFilteredUserGroups()
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
//      groupsArray = Content.getUserGroups(userId: userId) ?? []
    }
  }
  
  func updateUserGroupsOnServer() {
    if let userId = StorageContent.getUserId() {
//      Content.updateUserGroups(userId: userId, updatedGroupsArray: groupsArray)
    }
  }
  
  func updateFilteredUserGroups(){
    getUserGroups()
    filteredGroupsArray = groupsArray
  }
  
  //MARK: Navigation
  @IBAction func addGroup(segue: UIStoryboardSegue) {
      if let allGroupsTableViewController = segue.source as? AllGroupsTableViewController,
        let selectedIndexPath = allGroupsTableViewController.tableView.indexPathForSelectedRow {
         let selectedGroup = allGroupsTableViewController.groups[selectedIndexPath.row]

         if !groupsArray.contains(selectedGroup) {
            groupsArray.append(selectedGroup)
             tableView.reloadData()
         }
     }
 }
}
