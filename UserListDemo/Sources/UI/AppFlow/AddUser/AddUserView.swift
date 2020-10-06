//
//  AddUserView.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

class AddUserView: BaseView<AddUserViewModel> {

    // MARK: - Subtypes

    // MARK: - Properties
    
    @IBOutlet var contentScrollView: UIScrollView?
    
    @IBOutlet var firstNameLabel: UILabel?
    @IBOutlet var firstNameTextField: UITextField?
    @IBOutlet var firstNameTooltip: UILabel?
    
    @IBOutlet var lastNameLabel: UILabel?
    @IBOutlet var lastNameTextField: UITextField?
    @IBOutlet var lastNameTooltip: UILabel?
    
    @IBOutlet var emailLabel: UILabel?
    @IBOutlet var emailTextField: UITextField?
    @IBOutlet var emailTooltip: UILabel?
    
    @IBOutlet var userPhotoLabel: UILabel?
    @IBOutlet var userPhotoImageView: UIImageView?
    @IBOutlet var addUserPhotoButton: UIButton?
    
    @IBOutlet var addUserButton: UIButton?
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configure()
    }
      
    // MARK: - Public

    override public func fill(with viewModel: AddUserViewModel) {
        super.fill(with: viewModel)
        
    }
    
    // MARK: - Private
    
    private func configure() {
        
    }
}
