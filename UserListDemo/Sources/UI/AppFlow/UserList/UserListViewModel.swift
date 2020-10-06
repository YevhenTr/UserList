//
//  UserListViewModel.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

import RxRelay

enum UserListEvent {

}

class UserListViewModel: BaseViewModel<UserListEvent> {

    // MARK: - Properties
    
    public let users = BehaviorRelay<[UserModel]>(value: [])
    public let isLoading = BehaviorRelay<Bool>(value: false)
    
    private let networking: Networking
    
    // MARK: - Init and Deinit
    
    init(serviceContainer: ServiceContainer, eventHandler: @escaping Handler<UserListEvent>) {
        self.networking = serviceContainer.networking
        
        super.init(eventHandler: eventHandler)
    }
    
    // MARK: - Public
    
    public func getAllUsers() {
        self.isLoading.accept(true)
        
        self.networking.getAllUsers { [weak self] result in
            self?.isLoading.accept(false)
            
            switch result {
            case .failure(let error):
                self?.process(error: error)
            case .success(let model):
                self?.process(model: model)
            }
        }
    }

    // MARK: - Private
    
    private func process(model: [UserModel]) {
        debugPrint(model.count)
        self.users.accept(model)
    }
    
    private func process(error: Error) {
        debugPrint(error.localizedDescription)
    }
}

