//
//  User.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 04.04.2021.
//

import Foundation
import SwiftyJSON

class User {
    let id: Int
    private let photoUrlString: String
    let firstName: String
    let lastName: String
    
    var photoUrl: URL? { URL(string: photoUrlString)}
    
    init(json: SwiftyJSON.JSON) {
        self.id = json["id"].intValue
        self.photoUrlString = json["photo_100"].stringValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
    }
}

struct UserSection: Comparable {
    let title: Character
    let friends: [User]
    
    static func < (lhs: UserSection, rhs: UserSection) -> Bool {
        lhs.title < rhs.title
    }
    
    static func == (lhs: UserSection, rhs: UserSection) -> Bool {
        lhs.title == rhs.title
    }
}
