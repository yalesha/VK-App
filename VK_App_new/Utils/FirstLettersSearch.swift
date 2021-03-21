//
//  FirstLettersSearch.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import Foundation

class FirstLetterSearch {
  
  static func isMatched (searchBase: String, searchString: String) -> Bool {
    var isMatched: Bool = false
    var wordsInSearchBaseCount: Int = 1
    var wordsArray: [String] = []
    let searchBaseLowercased = searchBase.lowercased()
    let searchStringLowercased = searchString.lowercased()
    
    //array of words
    if searchBaseLowercased.contains(" ") {
      var word: [Character] = []
      for char in searchBaseLowercased {
       word.append(char)
        if (char == " ") {
          wordsInSearchBaseCount += 1
          wordsArray.append(String(word))
          print(word)
          print(wordsArray)
          word = []
        }
       }
      wordsArray.append(String(word))
      print(wordsArray)
      }
    else {
      //word in a string
      wordsArray.append(searchBaseLowercased)
    }
    for word in wordsArray {
      isMatched = false
      guard (word.count >= searchStringLowercased.count) else { return false}
      let searchBaseSubstring = word[..<searchStringLowercased.count]
      if (searchStringLowercased == String(searchBaseSubstring)) {
        isMatched = true
        break
        } else { isMatched = false }
    }
    return isMatched
  }
}
