//
//  ServiceContainer.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

struct ServiceContainer {
    
    // MARK: - Properties
    
    let networking: Networking
    
    // MARK: - Init and Deinit
    
    init() {
        self.networking = Networking(api: UserListAPI())
    }
}
