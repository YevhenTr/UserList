//
//  Networking+EditUser.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 08.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

extension Networking {
    
    public func edit(id: String, newUser: NewUserModel, completion: @escaping Handler<Result<EmptyModel, Error>>) {
        let encoder = JSONEncoder()
        
        guard let data = try? encoder.encode(newUser) else {
            return completion(.failure(EncoderError.invalidModel))
        }
        
        let queryItems = [URLQueryItem(name: "user_id", value: id)]
        let request = self.createRequest(method: .post,
                                         queryItems: queryItems,
                                         path: "/edit_user.php",
                                         body: data)

        return self.send(request: request, completion: completion)
    }
}
