//
//  SectionIndexCreator.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import Foundation

class GreySectionAndRightSection {
  
  static func greyWordSectionInList(array: [User]) -> [Character] {
    var indexArray: [Character] = []
    var indexSet = Set<Character>()
    for item in array {
      let firstLetter = item.lastName[0]
      indexSet.insert(firstLetter)
    }
    for char in indexSet{
      indexArray.append(char)
    }
    indexArray.sort()
    return indexArray
  }
  
    //MARK: Right word bar search
    
  static func rightWordSearchBar(array: [User]) -> [Character: [User]] {
    var friendIndexDictionary: [Character: [User]] = [:]
    
    for item in array {
      let firstLetter = item.lastName[0]
     if (friendIndexDictionary.keys.contains(firstLetter)) {
         friendIndexDictionary[firstLetter]?.append(item)
     } else {
      friendIndexDictionary[firstLetter] = [item]
      }
    }
    return friendIndexDictionary
  }
}
