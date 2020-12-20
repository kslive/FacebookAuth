//
//  CurrentUser.swift
//  Facebook Auth
//
//  Created by Eugene Kiselev on 20.12.2020.
//

import Foundation

struct CurrentUser {
    let uId: String?
    let name: String?
    let email: String?
    
    init?(uId: String, data: [String: Any]) {
        guard let name = data["name"] as? String,
              let email = data["email"] as? String
        else { return nil }
        
        self.uId = uId
        self.name = name
        self.email = email
    }
}
