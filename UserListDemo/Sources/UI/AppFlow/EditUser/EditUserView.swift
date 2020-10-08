//
//  EditUserView.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 08.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

class EditUserView: BaseView<EditUserViewModel> {

    // MARK: - Subtypes

    // MARK: - Properties

    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configure()
    }
      
    // MARK: - Public

    override public func fill(with viewModel: EditUserViewModel) {
        super.fill(with: viewModel)
        
    }
    
    // MARK: - Private
    
    private func configure() {
        
    }
}
