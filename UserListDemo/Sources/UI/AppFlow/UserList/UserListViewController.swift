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
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.getAllUsers()
    }
    
    // MARK: - Private
    
    private func configure() {
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                            target: self,
                                            action: #selector(self.onAddUser))
        self.navigationItem.setRightBarButton(addButtonItem, animated: false)
        
        self.title = AppTextConstants.UserList.navigationTitle
    }
    
    @objc
    private func onAddUser(_ sender: UIBarButtonItem) {
        self.viewModel.addUser()
    }
}
