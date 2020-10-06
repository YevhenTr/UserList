//
//  UserTableViewCell.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

import Kingfisher

enum EmptyCellEvent {
    
}

class UserTableViewCell: BaseCell<UserModel, EmptyCellEvent> {

    // MARK: - Properties
    
    @IBOutlet var userName: UILabel?
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.reset()
    }
    
    // MARK: - Public
    
    public override func fill(with model: UserModel) {
        self.userName?.text = model.firstName
    }
    
    // MARK: - Private
    
    private func reset() {
        
    }
}
