//
//  Session.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 21.03.2021.
//

import Foundation

class Session {
    
    var token: String = ""
    var userId: Int = 0
    
    private init() {}
    
    static let shared = Session()
    
}
