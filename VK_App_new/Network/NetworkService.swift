//
//  NetworkService.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 27.03.2021.
//

import Foundation
import Alamofire
import SwiftyJSON


class NetworkService {
    
   let baseUrl = "https://api.vk.com"
    private let accessToken: String
    
    var firstParams: Parameters {
        [
        "access_token": accessToken,
        "extended": 1,
        "v": "5.130"
        ]
    }
    init(token: String) {
        self.accessToken = token
    }
    
    func loadGroups(completionHandler: @escaping ((Result<[Group], Error>) -> Void)) {
        let path = "/method/groups.get"
        
        AF.request(baseUrl + path, method: .get, parameters: firstParams).responseData {
            response in
            switch response.result {
            case let .success(data):
                do {
                let groupsResponse = try JSONDecoder().decode(GroupResponse.self, from: data)
                    let groups = groupsResponse.response.items
                    completionHandler(.success(groups))
                } catch {
                    completionHandler(.failure(error))
                }
            case let .failure(error):
                completionHandler(.failure(error))

            }
         
        }
    }
    
    
    
    func loadFriends(completionHandler: @escaping ((Result<[User], Error>) -> Void)) {
        let path = "/method/friends.get"
        var params = firstParams
        params["fields"] = [ "photo_100" ]
        AF.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
//            guard let json = response.value.map(JSON.init) else { return }
            switch response.result {
            case let .failure(error):
                completionHandler(.failure(error))
            case let .success(json):
                let friendsJSONArray = JSON(json)["response"]["items"].arrayValue
                let friends = friendsJSONArray.map(User.init)
                completionHandler(.success(friends))
            }
            
        
/// View in console
//            print("first friend \(friends[0])")
        }
    }
    
//    static func loadFriendsPhoto(token: String) {
//        let path = "/method/friends.get"
//
//
//        let params: Parameters = [
//            "access_token": token,
//            "extended": 0,
//            "fields": "photo_50",
//            "v": "5.130"
//        ]
//        AF.request(baseUrl + path, method: .get, parameters: params).responseJSON {
//            response in
//            guard let json = response.value else { return }
//            print(json)
//        }
//    }
//
    func loadGroupSearch(group: String, completionHandler: @escaping ((Result<[Group], Error>) -> Void)) {
        let path = "/method/groups.search"

        var params = firstParams
        params["q"] = group
        
        AF.request(baseUrl + path, method: .get, parameters: params).responseData {
            response in
            switch response.result {
            case let .success(data):
                do {
                let groupsResponse = try JSONDecoder().decode(GroupResponse.self, from: data)
                    let groups = groupsResponse.response.items
                    completionHandler(.success(groups))
                } catch {
                    completionHandler(.failure(error))
                }
            case let .failure(error):
                completionHandler(.failure(error))

            }
        }
    }
    
}
