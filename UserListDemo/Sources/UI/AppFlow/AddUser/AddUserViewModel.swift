//
//  AddUserViewModel.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

enum AddUserEvent {

}

class AddUserViewModel: BaseViewModel<AddUserEvent> {

    // MARK: - Properties
    
    private let networking: Networking
    
    // MARK: - Init and Deinit
    
    init(serviceContainer: ServiceContainer, eventHandler: @escaping Handler<AddUserEvent>) {
        self.networking = serviceContainer.networking
        
        super.init(eventHandler: eventHandler)
    }
    
    // MARK: - Public

    // MARK: - Private
}

