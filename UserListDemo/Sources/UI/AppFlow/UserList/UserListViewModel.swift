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
    case showUser(user: UserModel)
    case addUser
    case error(Error)
}

class UserListViewModel: BaseViewModel<UserListEvent> {

    // MARK: - Properties
    
    public let users = BehaviorRelay<[UserViewData]>(value: [])
    public let isLoading = BehaviorRelay<Bool>(value: false)
    
    private let networking: Networking
    
    private var rowUsers = [UserModel]()
    
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
        if let user = self.rowUsers.object(at: indexPath.row) {
            self.eventHandler(.showUser(user: user))
        } else {
            debugPrint("Error: Couldn't find user on index \(indexPath.row)")
        }
    }
    
    public func addUser() {
        self.eventHandler(.addUser)
    }

    // MARK: - Private
    
    private func process(model: [UserModel]) {
        let userViewData = model.map(UserViewData.init(userModel:))
        
        self.rowUsers = model
        self.users.accept(userViewData)
    }
    
    private func process(error: Error) {
        self.eventHandler(.error(error))
    }
}

