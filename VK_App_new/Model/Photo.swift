//
//  Photo.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 04.04.2021.
//

import Foundation

class PhotoResponse: Codable {
    let response: Photos
}

class Photos: Codable {
    let count: Int
    let items: [Photo]
}
