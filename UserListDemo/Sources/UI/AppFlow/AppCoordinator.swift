//
//  AppCoordinator.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

public final class AppCoordinator: BaseCoordinator<AppCoordinator.Event> {

    // MARK: - Subtypes
    
    public enum Event {
    }
        
    // MARK: - Properties
    
    private let serviceContainer: ServiceContainer
        
    private var userListViewController: UserListViewController?
    
    // MARK: - Init and Deinit
    
    init(serviceContainer: ServiceContainer, eventHandler: @escaping Handler<AppCoordinator.Event>) {
        self.serviceContainer = serviceContainer
        
        super.init(eventHandler: eventHandler)
        
        self.navigationController.isNavigationBarHidden = false
    }
    
    // MARK: - Public
     
    override func rootViewController() -> UIViewController {
        return self.userListViewController ?? self.createUserListViewController()
    }
    
    // MARK: - Private
    
    private func createUserListViewController() -> UserListViewController {
        let viewModel = UserListViewModel(serviceContainer: self.serviceContainer, eventHandler: self.userListEventHandler)
        let controller = UserListViewController(viewModel: viewModel)
        
        self.userListViewController = controller
        
        return controller
    }
    
    private func userListEventHandler(_ event: UserListEvent) {
        switch event {
        case .addUser:
            self.push(controller: self.createAddUserViewController())
        case .showUser(let user):
            debugPrint("showUser \(user.id)")
            self.push(controller: self.createEditUserViewController(user: user))
        case .error(let error):
            debugPrint("error \(error.localizedDescription)")
        }
    }
    
    private func createAddUserViewController() -> InputFormViewController {
        let viewModel = AddUserViewModel(serviceContainer: self.serviceContainer, eventHandler: self.inputFormEventHandler)
        let controller = InputFormViewController(viewModel: viewModel)
        
        return controller
    }
    
    private func createEditUserViewController(user: UserModel) -> InputFormViewController {
        let viewModel = EditUserViewModel(user: user, serviceContainer: self.serviceContainer, eventHandler: self.inputFormEventHandler)
        let controller = InputFormViewController(viewModel: viewModel)

        return controller
    }
    
    private func inputFormEventHandler(_ event: InputFormEvent) {
        switch event {
        case .error(let error):
            debugPrint(error.localizedDescription)
        case .back:
            self.pop()
        }
    }
}
