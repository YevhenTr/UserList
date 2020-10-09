//
//  InputFormViewModel.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

enum InputFormEvent {
    case back
    case error(Error)
}

class InputFormViewModel: BaseViewModel<InputFormEvent> {

    // MARK: - Properties
    
    public let keyboardNotificationService: KeyboardNotificationsService
    public let networking: Networking
    public let user: UserModel?
    
    // MARK: - Init and Deinit
    
    init(user: UserModel? = nil, serviceContainer: ServiceContainer, eventHandler: @escaping Handler<InputFormEvent>) {
        self.networking = serviceContainer.networking
        self.keyboardNotificationService = serviceContainer.keyboardNotificationService
        self.user = user
        
        super.init(eventHandler: eventHandler)
    }
    
    // MARK: - Public
    
    open func save(newUser: NewUserModel) {
        
    }
    
    public func show(error: Error) {
        self.eventHandler(.error(error))
    }
}

