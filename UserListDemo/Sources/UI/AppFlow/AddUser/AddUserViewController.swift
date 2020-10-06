//
//  AddUserViewController.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

class AddUserViewController: BaseViewController<AddUserView, AddUserViewModel> {

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
    }
    
    // MARK: - Private
    
    private func configure() {
        self.title = AppTextConstants.AddUser.navigationTitle
    }
}
