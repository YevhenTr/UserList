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

    typealias Text = AppTextConstants.AddUser
    
    private enum Constant {
        static let cornerRadius: CGFloat = 5
        static let borderWidth: CGFloat = 1
    }
    
    // MARK: - Properties
    
    @IBOutlet var contentScrollView: UIScrollView?

    @IBOutlet var firstNameInputView: NameInputView?
    @IBOutlet var lastNameInputView: NameInputView?
    @IBOutlet var emailNameInputView: EmailInputView?

    @IBOutlet var userPhotoLabel: UILabel?
    @IBOutlet var userPhotoImageView: UIImageView?
    @IBOutlet var addUserPhotoButton: UIButton?
    
    @IBOutlet var addUserButton: UIButton?
    
    private lazy var bottomInset = UIApplication.shared.windows
        .filter {$0.isKeyWindow}
        .first?
        .safeAreaInsets.bottom
        ?? 0
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configure()
    }
      
    // MARK: - Public

    override public func fill(with viewModel: AddUserViewModel) {
        super.fill(with: viewModel)
        
        self.bindKeyboardService(with: viewModel)
    }
    
    // MARK: - Private
    
    private func configure() {
        self.addHideKeyboardGeasture()
        
        self.firstNameInputView?.titleText = Text.firstNameTitle
        self.lastNameInputView?.titleText = Text.lastNameTitle
        self.emailNameInputView?.titleText = Text.emailTitle
        
        self.userPhotoLabel?.text = Text.photoTitle
        
        self.userPhotoImageView?.image = UIImage(named: "userphoto_placeholder_image")
        
        self.addUserPhotoButton?
            .set(cornerRadius: Constant.cornerRadius)
            .set(borderColor: .systemBlue)
            .set(borderWidth: Constant.borderWidth)
            .setTitle(Text.photoButton, for: .normal)

        self.addUserButton?
            .set(cornerRadius: Constant.cornerRadius)
            .setTitle(Text.addUserButton, for: .normal)
    }
    
    private func bindKeyboardService(with viewModel: AddUserViewModel) {
        let bottomInset = self.bottomInset
        let scrollView = self.contentScrollView
        
        viewModel.keyboardNotificationService.eventHandler = { [weak self] event in
            switch event {
            case .hidden:
                scrollView?.contentInset = .zero
            case .visible(let endFrame, _):
                scrollView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: endFrame.height - bottomInset, right: 0)
            }
        
            self?.layoutIfNeeded()
        }
    }
}
