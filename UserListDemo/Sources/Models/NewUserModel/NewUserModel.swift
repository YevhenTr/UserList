//
//  NewUserModel.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

/*
 
 {
     "user": {
        "first_name": "Steve",
        "last_name": "Jobs",
        "email": "ceo@apple.com",
        "image_url": "http://www.fillmurray.com/200/200.jpg"
     }
 }
 
 */

struct NewUserModel: Codable {
    
    let user: NewUserData
}

extension NewUserModel {
    
    init(firstName: String, lastName: String, email: String, imageURL: String = "") {
        self.user = NewUserData(firstName: firstName,
                                lastName: lastName,
                                email: email,
                                imageURL: imageURL)
    }
}

struct NewUserData: Codable {
    
    // MARK: - Subtypes
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case imageURL = "image_url"
    }
    
    // MARK: - Properties
    
    let firstName: String
    let lastName: String
    let email: String
    let imageURL: String
}
