//
//  FriendsTableViewController.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController, UISearchBarDelegate {
    
    // unwindToFriendsWithSegue
  
    var friends = [User]()
    private let networkSession = NetworkService(token: Session.shared.token)
    
    @IBOutlet weak var friendsSearchBar: UISearchBar!
    
    @IBAction func logOut(_ sender: UIButton) {
    }
    var sectionedFriends: [UserSection] {
        friends.reduce(into: []) {
            currentSectionFriends, friend in
            guard let firstLetter = friend.lastName.first else { return }
            
            if let currentSectionFriendFirstLetterIndex = currentSectionFriends.firstIndex(where: { $0.title == firstLetter }) {
                
                let oldSection = currentSectionFriends[currentSectionFriendFirstLetterIndex]
                let updatedSection = UserSection(title: firstLetter, friends: oldSection.friends + [friend])
                currentSectionFriends[currentSectionFriendFirstLetterIndex] = updatedSection
                
            } else {
                let newSection = UserSection(title: firstLetter, friends: [friend])
                currentSectionFriends.append(newSection)
            }
        }.sorted()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FriendHeader.self, forHeaderFooterViewReuseIdentifier: FriendHeader.reuseIdentifier)
    }
    override func viewWillAppear(_ animated: Bool) {
        networkSession.loadFriends(completionHandler: { [weak self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(friends):
                self?.friends = friends
                self?.tableView.reloadData()
            }
        })
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FriendHeader.reuseIdentifier) as? FriendHeader else { return nil }
        
        let firstLetter = String(sectionedFriends[section].title)
        header.headerTitle.text = firstLetter
        
        return header
    }
    
  //MARK: Setup tableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionedFriends.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionedFriends[section].friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as? FriendsListCell else { return UITableViewCell() }
        cell.configure(with: sectionedFriends[indexPath.section].friends[indexPath.row])
        tableView.separatorStyle = .singleLine
      return cell
    }
    
    
  
// 
  
////  MARK: Setup searchBar
//  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//    searchActive = true
//  }
//
//  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//    hideKeyboard()
//  }
//
//
//  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//    filteredFriendsArray = friends.filter({ (friend) -> Bool in
//      FirstLetterSearch.isMatched(searchBase: friend.lastName, searchString: searchText)
//    })
//
//    updateFriendsIndex(friends: filteredFriendsArray)
//    updateFriendsNamesDictionary(friends: filteredFriendsArray)
//    print(filteredFriendsArray)
//
//    if (searchText.count == 0) {
//      updateFriendsIndex(friends: friends)
//      updateFriendsNamesDictionary(friends: friends)
//      searchActive = false
//      hideKeyboard()
//    }
//    tableView.reloadData()
//  }
//
//  @objc func hideKeyboard() {
//    searchActive = false
//    friendsSearchBar.endEditing(true)
//  }
//
//  //MARK: First word section in list and right bar
//
//  func updateFriendsNamesDictionary(friends: [User]) {
//    friendsIndexDictionary = GreySectionAndRightSection.rightWordSearchBar(array: friends)
//  }
//
//  func updateFriendsIndex(friends: [User]) {
//    friendsIndex = GreySectionAndRightSection.greyWordSectionInList(array: friends)
//  }
  
//  // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "segueToFriendDetails",
//           let cellIndexPath = tableView.indexPathForSelectedRow,
//           let friendViewController = segue.destination as? FriendsCollectionViewController {
//            let selectedFriend = sectionedFriends[cellIndexPath.section].friends[cellIndexPath.row]
//            friendViewController.friendToDisplay = selectedFriend
//        }
//    }
}
