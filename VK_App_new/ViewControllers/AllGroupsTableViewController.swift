//
//  AllGroupsTableViewController.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import UIKit

class AllGroupsTableViewController: UITableViewController {
  
  var availableGroupsArray = [Group]()
//  var filteredAvailableGroupsArray = [Group]()
    var groups = [Group]()
    private let networkSession = NetworkService(token: Session.shared.token)
  
  @IBOutlet var availableGroupsTableView: UITableView!
  @IBOutlet weak var allGroupsSearchBar: UISearchBar!
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
//        getAvailableGroups()
//        filteredAvailableGroupsArray = availableGroupsArray
//        availableGroupsTableView.keyboardDismissMode = .onDrag
    }
    


    override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//      let avatarName = filteredAvailableGroupsArray[indexPath.row].avatarPath
//      let avatarImage = UIImage(named: avatarName)
//      let groupsName = filteredAvailableGroupsArray[indexPath.row].name
        let cell = tableView.dequeueReusableCell(withIdentifier: "availableGroupsCell", for: indexPath) as! GroupsListCell
        
        cell.configureGroup(with: groups[indexPath.row])
        tableView.separatorStyle = .singleLine
//      cell.groupsAvatar.image = avatarImage
//      cell.groupsName.text = groupsName
      return cell
    }
  
  //MARK: searchBar
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    hideKeyboard()
  }
  
  
  
  @objc func hideKeyboard() {
    allGroupsSearchBar.endEditing(true)
  }


//  func getAvailableGroups() {
////    availableGroupsArray = Content.getAvailableGroups() ?? []
//  }
//
//  func restoreAvailableGroups(){
//    getAvailableGroups()
//    filteredAvailableGroupsArray = availableGroupsArray
//  }
}
extension AllGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        networkSession.loadGroupSearch(group: searchText, completionHandler: {[ weak self ] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(groups):
                self?.groups = groups
                self?.tableView.reloadData()
            }
        })
    }
}
