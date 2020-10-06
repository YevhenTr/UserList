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
        default:
            break
        }
    }
}
