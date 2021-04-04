//
//  Group.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 04.04.2021.
//

import Foundation

struct GroupResponse: Codable {
    let response: Groups
}

struct Group: Codable {
    let count: Int
    let items: [Group]
}
