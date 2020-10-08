//
//  EditUserViewModel.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 08.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

enum EditUserEvent {

}

class EditUserViewModel: BaseViewModel<EditUserEvent> {

    // MARK: - Properties
    
    private let networking: Networking
    
    // MARK: - Init and Deinit
    
    init(serviceContainer: ServiceContainer, eventHandler: @escaping Handler<EditUserEvent>) {
        self.networking = serviceContainer.networking
        
        super.init(eventHandler: eventHandler)
    }
    
    // MARK: - Public

    // MARK: - Private
}

