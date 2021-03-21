//
//  Friends.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import Foundation

struct Friends {
  let name: String
  let avatarPath: String
    var photos = [String]()
  
    init (name: String, avatarPath: String, photos: [String]) {
    self.name = name
    self.avatarPath = avatarPath
    self.photos = photos
  }
}
