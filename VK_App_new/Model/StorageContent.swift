//
//  StorageEmulator.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import Foundation

class StorageContent {
  
  static let userIdKey = "userIdKey"
  static let friendsArrayKey = "friendsArrayKey"
  
  static func setUserId(userId: String) {
    if (userId != getUserId()) {
    UserDefaults.standard.set(userId, forKey: userIdKey)
    }
  }
  
  static func getUserId() -> String? {
    return UserDefaults.standard.string(forKey: userIdKey)
  }
 
  static func getFriendsArray() -> [User]? {
    return UserDefaults.standard.object(forKey: friendsArrayKey) as? [User]
  }
}
