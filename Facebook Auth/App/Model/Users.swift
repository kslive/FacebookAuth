//
//  Users.swift
//  Facebook Auth
//
//  Created by Eugene Kiselev on 20.12.2020.
//

import Foundation

struct Users {
    let id: String?
    let name: String?
    let email: String?
    
    init(data: [String: Any]) {
        let id = data["id"] as? String
        let name = data["name"] as? String
        let email = data["email"] as? String
        
        self.id = id
        self.name = name
        self.email = email
    }
}
