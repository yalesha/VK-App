//
//  NetworkService.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 27.03.2021.
//

import Foundation
import Alamofire

class NetworkService {
    
   static let baseUrl = "https://api.vk.com"
    
    static func loadGroups(token: String) {
        let path = "/method/groups.get"
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.130"
        ]
        AF.request(baseUrl + path, method: .get, parameters: params).responseJSON {
            response in
            guard let json = response.value else { return }
            print(json)
        }
    }
    
    static func loadFriends(token: String) {
        let path = "/method/friends.get"
        
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.130"
        ]
        AF.request(baseUrl + path, method: .get, parameters: params).responseJSON {
            response in
            guard let json = response.value else { return }
            print(json)
        }
    }
    
    static func loadFriendsPhoto(token: String) {
        let path = "/method/friends.get"
        
        
        let params: Parameters = [
            "access_token": token,
            "extended": 0,
            "fields": "photo_50",
            "v": "5.130"
        ]
        AF.request(baseUrl + path, method: .get, parameters: params).responseJSON {
            response in
            guard let json = response.value else { return }
            print(json)
        }
    }
    
    static func loadGroupSearch(token: String) {
        let path = "/method/groups.search"
        
        
        let params: Parameters = [
            "access_token": token,
            "q": group(),
            "type": "group",
            "v": "5.130"
        ]
        AF.request(baseUrl + path, method: .get, parameters: params).responseJSON {
            response in
            guard let json = response.value else { return }
            print(json)
        }
    }
    
}
