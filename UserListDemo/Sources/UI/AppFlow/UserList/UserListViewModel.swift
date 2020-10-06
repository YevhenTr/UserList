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
    case showUser(id: String)
    case addUser
    case error(Error)
}

class UserListViewModel: BaseViewModel<UserListEvent> {

    // MARK: - Properties
    
    public let users = BehaviorRelay<[UserViewData]>(value: [])
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
    
    public func showUser(indexPath: IndexPath) {
        let user = self.users.value.object(at: indexPath.row)
        
        if let id = user?.id {
            self.eventHandler(.showUser(id: id))
        }
    }
    
    public func addUser() {
        self.eventHandler(.addUser)
    }

    // MARK: - Private
    
    private func process(model: [UserModel]) {
        let userViewData = model.map(UserViewData.init(userModel:))
        
        self.users.accept(userViewData)
    }
    
    private func process(error: Error) {
        self.eventHandler(.error(error))
    }
}

