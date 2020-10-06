//
//  UserModel.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

/*
 
 {
     "id": "572",
     "first_name": "Face",
     "last_name": "Mironovi4",
     "email": "face@ffgh.ty",
     "image_url": "https://i.imgur.com/JxIotrM.jpg",
     "created": "2018-10-15 20:11:08",
     "updated": "0000-00-00 00:00:00"
 },
 
 */

struct UserModel: Codable {
    
    // MARK: - Subtypes
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case imageURL = "image_url"
    }
    
    // MARK: - Properties
    
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let imageURL: String
}

struct UserViewData {
    
    // MARK: - Properties
    
    let fullName: String
    let email: String
    let photoURL: URL?
}

extension UserViewData {
    
    init(userModel: UserModel) {
        self.fullName = userModel.firstName + " " + userModel.lastName
        self.email = userModel.email
        self.photoURL = URL(string: userModel.imageURL)
    }
}
