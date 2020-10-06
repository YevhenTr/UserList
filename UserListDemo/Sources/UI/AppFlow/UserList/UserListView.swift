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

    @IBOutlet var usersTableView: UITableView?
    
    private var tableAdapter: TableAdapter?

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
        
        viewModel.users
            .observeOn(MainScheduler.asyncInstance)
            .bind { [weak self] models in
                self?.tableAdapter?.sections = [Section(cell: UserTableViewCell.self, models: models)]
            }
            .disposed(by: self)
        
    }
    
    // MARK: - Private
    
    private func configure() {
        self.tableAdapter = TableAdapter(table: self.usersTableView, cells: [UserTableViewCell.self])
    }
}
