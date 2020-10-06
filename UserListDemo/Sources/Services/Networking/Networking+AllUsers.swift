//
//  Networking+AllUsers.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

extension Networking {
    
    public func getAllUsers(completion: @escaping Handler<Result<[UserModel], Error>>) {
        let request = self.createRequest(path: "/users.php")

        return self.send(request: request, completion: completion)
    }
}
