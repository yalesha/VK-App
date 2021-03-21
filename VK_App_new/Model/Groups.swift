//
//  Groups.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import Foundation

struct Groups: Equatable {
  let name: String
  let avatarPath: String
  
  init (name: String, avatarPath: String) {
    self.name = name
    self.avatarPath = avatarPath
  }
}
