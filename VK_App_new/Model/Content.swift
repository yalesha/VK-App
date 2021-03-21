//
//  ServerEmulator.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import Foundation

class Content {
    
  static var friendEgor = Friends(name: "Ivan", avatarPath: "1001", photos: ["1001", "2002"])
  static var friendStas = Friends(name: "Maxim", avatarPath: "2002", photos: ["3003", "4004"])
  static var friendJenya = Friends(name: "Stas", avatarPath: "3003", photos: ["5005", "6006"])
    static var friendKatya = Friends(name: "Kate", avatarPath: "4004", photos: ["7007", "8008"])
    static var friendGleb = Friends(name: "Jessica", avatarPath: "5005", photos: ["1001", "2002"])
    static var friendAlexey = Friends(name: "Naomi", avatarPath: "6006", photos: ["3003", "4004"])
    static var friendBoris = Friends(name: "Jack", avatarPath: "7007", photos: ["5005", "6006"])
    static var friendVictor = Friends(name: "Lucy", avatarPath: "8008", photos: ["7007", "8008"])


  
  
  static var groupsInstagram = Groups(name: "Instagram", avatarPath: "instagram")
  static var groupsFacebook = Groups(name: "Facebook", avatarPath: "facebook")
  static var groupsBadoo = Groups(name: "Badoo", avatarPath: "badoo")
  static var groupsTelegram = Groups(name: "Telegram", avatarPath: "telegram")
  static var groupsViber = Groups(name: "Viber", avatarPath: "viber")
  static var groupsTwitter = Groups(name: "Twitter", avatarPath: "twitter")
  
    
  static var newsOne = News(newsId: "1", newsText: "Роскомнадзор начал замедлять скорость работы Twitter в России", picturesArray: ["756153613809707", "756153618588825", "756153675476892", "756154061992548", "756154415855320", "756154606690044", "756155279709159"], likesCount: 0, commentsCount: 0, sharesCount: 0, viewsCount: 0)
  
  static var newsTwo = News(newsId: "2", newsText: "На первом этапе будет замедлен доступ к Twitter с половины компьютеров в России и со всех мобильных устройств. Эта мера применяется впервые. В дальнейшем Роскомнадзор может заблокировать доступ к сервису", picturesArray: ["756154606690044"], likesCount: 0, commentsCount: 0, sharesCount: 0, viewsCount: 0)
  
  
  
  //user dictionary
  static var userFriendsDataBase = ["user001": [
    friendEgor,
    friendStas,
    friendJenya,
    friendKatya,
    friendGleb,
    friendAlexey,
    friendBoris,
    friendVictor
  ]]
  
    static var userImagesIvan = ["Ivan": [
    "1001",
    "2002",
    "3003",
    "4004"
    ]]
    
    static var userImagesAll = [friendEgor,
                                friendStas,
                                friendJenya,
                                friendKatya,
                                friendGleb,
                                friendAlexey,
                                friendBoris,
                                friendVictor]
    
  
  
  
  //set users groups 'database' as a simple dictionary
  static var userGroupsDataBase = ["user001": [groupsInstagram]]

  //set users groups 'database' as a simple dictionary
  static var availableGroupsDataBase = [groupsInstagram, groupsFacebook, groupsBadoo, groupsTelegram, groupsViber, groupsTwitter]
  
  static var newsDataBase = [newsOne, newsTwo]
  
  
  static func getFriends(userId: String) -> [Friends]? {
     return userFriendsDataBase[userId]
  }
  
  static func updateUserFriends(userId: String, updatedFriendsArray: [Friends]) {
    userFriendsDataBase.updateValue(updatedFriendsArray, forKey: userId)
  }
  
  static func getUserGroups(userId: String) -> [Groups]? {
    return userGroupsDataBase[userId]
  }
  
  static func getAvailableGroups() -> [Groups]? {
    return availableGroupsDataBase
  }
  
  static func updateUserGroups(userId: String, updatedGroupsArray: [Groups]) {
    userGroupsDataBase.updateValue(updatedGroupsArray, forKey: userId)
  }
  
  static func getNews() -> [News]? {
    return newsDataBase
  }
  
  static func getUserImages(userName: String) -> [String] {
     return userImagesIvan[userName] ?? []
    
  }
}
