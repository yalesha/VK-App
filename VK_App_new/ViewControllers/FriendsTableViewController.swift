//
//  FriendsTableViewController.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController, UISearchBarDelegate {
  
  var friendsArray: [Friends] = []
  var filteredFriendsArray: [Friends] = []
  var friendsIndex: [Character] = []
  var friendsIndexDictionary: [Character: [Friends]] = [:]
  var searchActive = false
  
 
    @IBAction func logOut(unwindSegue: UIStoryboardSegue) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var friendsSearchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        getFriends()
        //set initial state of tableViewdataSource to data reseived from the server
        filteredFriendsArray = friendsArray
        //create ordered first-letter array
        updateFriendsIndex(friends: filteredFriendsArray)
        //create a dictionary to map names starting from the same letter to one index
        updateFriendsNamesDictionary(friends: filteredFriendsArray)
        tableView.keyboardDismissMode = .onDrag
    }
  //MARK: Setup tableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return friendsIndex.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      let char = friendsIndex[section]
      let rowsCount: Int  = friendsIndexDictionary[char]?.count ?? 0
      return rowsCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let char = friendsIndex[indexPath.section]
      let avatarName = friendsIndexDictionary[char]?[indexPath.row].avatarPath ?? "defaultAvatar.png"
      let avatarImage = UIImage(named: avatarName)
      let friendsName = friendsIndexDictionary[char]?[indexPath.row].name ?? "Ошибка получения имени"
      let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsListCell
      cell.friendsAvatar.image = avatarImage
      cell.friendsName.text = friendsName
      tableView.separatorStyle = .none
      return cell
    }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return String(friendsIndex[section])
  }
  
  override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    guard !searchActive else { return nil }
    let friendsIndexToStringArray = friendsIndex.map { String($0) }
    return friendsIndexToStringArray
  }
  
  override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
    if let header: UITableViewHeaderFooterView = view as? UITableViewHeaderFooterView {
      header.backgroundView?.backgroundColor = tableView.backgroundColor
      header.backgroundView?.alpha = 0.5
    }
  }
  
  //MARK: Setup searchBar
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchActive = true
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    hideKeyboard()
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    filteredFriendsArray = friendsArray.filter({ (friend) -> Bool in
      FirstLetterSearch.isMatched(searchBase: friend.name, searchString: searchText)
    })

    updateFriendsIndex(friends: filteredFriendsArray)
    updateFriendsNamesDictionary(friends: filteredFriendsArray)
    print(filteredFriendsArray)

    if (searchText.count == 0) {
      updateFriendsIndex(friends: friendsArray)
      updateFriendsNamesDictionary(friends: friendsArray)
      searchActive = false
      hideKeyboard()
    }
    tableView.reloadData()
  }
  
  @objc func hideKeyboard() {
    searchActive = false
    friendsSearchBar.endEditing(true)
  }

  //MARK: Prepare datasource
  func getFriends() {
    if let userId = StorageContent.getUserId() {
      friendsArray = Content.getFriends(userId: userId) ?? []
    }
  }
  //MARK: First word section in list and right bar
    
  func updateFriendsNamesDictionary(friends: [Friends]) {
    friendsIndexDictionary = GreySectionAndRightSection.rightWordSearchBar(array: friends)
  }
  
  func updateFriendsIndex(friends: [Friends]) {
    friendsIndex = GreySectionAndRightSection.greyWordSectionInList(array: friends)
  }
  
  // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    hideKeyboard()
      if let destination = segue.destination as? FriendsCollectionViewController {
        if let selection = self.tableView.indexPathForSelectedRow {
          let char = friendsIndex[selection.section]
          if let selectedFriend = friendsIndexDictionary[char]?[selection.row] {
            destination.friendToDisplay = selectedFriend
          }
        }
      }
    }
  
  @IBAction func unwindToFriends(unwindSegue: UIStoryboardSegue) {
    
  }
}
