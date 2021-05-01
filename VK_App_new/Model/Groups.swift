//
//  Groups.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import Foundation

struct GroupResponse: Codable {
    let response: GroupContainer
}

struct GroupContainer: Codable {
    let items: [Group]
}




struct Group: Codable, Equatable {
  let name: String
    let groupId: Int
    private let pictureUrlString: String
    var pictureUrl: URL? { URL(string: pictureUrlString)}
    
    enum CodingKeys: String, CodingKey {
        case groupId = "id"
        case name
        case pictureUrlString = "photo_200"
    }
    
}
struct GroupSection: Comparable {
    let title: Character
    let groups: [Group]
    
    static func < (lhs: GroupSection, rhs: GroupSection) -> Bool {
        lhs.title < rhs.title
    }
    
    static func == (lhs: GroupSection, rhs: GroupSection) -> Bool {
        lhs.title == rhs.title
    }
}
