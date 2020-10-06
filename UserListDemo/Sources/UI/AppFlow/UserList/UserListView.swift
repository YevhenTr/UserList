//
//  UserListView.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class UserListView: BaseView<UserListViewModel> {

    // MARK: - Subtypes

    // MARK: - Properties

    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configure()
    }
      
    // MARK: - Public

    override public func fill(with viewModel: UserListViewModel) {
        super.fill(with: viewModel)
        
        viewModel.isLoading
            .observeOn(MainScheduler.asyncInstance)
            .bind { debugPrint("isLoading \($0)") }
            .disposed(by: self)
        
    }
    
    // MARK: - Private
    
    private func configure() {
        
    }
}
