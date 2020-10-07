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
    
    public let keyboardNotificationService: KeyboardNotificationsService

    private let networking: Networking
    
    // MARK: - Init and Deinit
    
    init(serviceContainer: ServiceContainer, eventHandler: @escaping Handler<AddUserEvent>) {
        self.networking = serviceContainer.networking
        self.keyboardNotificationService = serviceContainer.keyboardNotificationService
        
        super.init(eventHandler: eventHandler)
    }
    
    // MARK: - Public
    
    public func add(newUser: NewUserModel) {
//        self.networking.add(newUser: model) { result in
//            switch result {
//            case .failure(let error):
//                debugPrint(error)
//            case .success:
//                debugPrint("success")
//            }
//        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) {
            debugPrint("error or succes")
        }
    }
    
    // MARK: - Private
}

