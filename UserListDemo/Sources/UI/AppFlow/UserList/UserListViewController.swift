//
//  UserListViewController.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

class UserListViewController: BaseViewController<UserListView, UserListViewModel> {

    // MARK: - View Lifecycle
    
    var networking: Networking?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networking = Networking(api: UserListAPI())
        self.networking = networking
        networking.getAllUsers { result in
            switch result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
            case .success(let model):
                debugPrint(model.count)
            }
        }
    }
}
