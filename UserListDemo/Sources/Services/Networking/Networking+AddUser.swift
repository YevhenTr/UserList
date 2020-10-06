//
//  Networking+AddUser.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

extension Networking {
    
    public func add(newUser: NewUserModel, completion: @escaping Handler<Result<EmptyModel, Error>>) {
        let encoder = JSONEncoder()
        
        guard let data = try? encoder.encode(newUser) else {
            return completion(.failure(EncoderError.invalidModel))
        }
        
        let request = self.createRequest(method: .post, path: "/users.php", body: data)

        return self.send(request: request, completion: completion)
    }
}
