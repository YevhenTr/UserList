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

        self.bindInputFields(with: viewModel)
    }
    
    // MARK: - Private
    
    private func configure() {
        self.addHideKeyboardGeasture()
        
        self.firstNameLabel?.text = Text.firstNameTitle
        self.lastNameLabel?.text = Text.lastNameTitle
        self.emailLabel?.text = Text.emailTitle
        self.userPhotoLabel?.text = Text.photoTitle
        
        [
            self.firstNameTooltip,
            self.lastNameTooltip,
            self.emailTooltip,
        ]
            .forEach { $0?.text = " " }
        
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
    
    private func bindInputFields(with viewModel: AddUserViewModel) {
        let firstNameField = self.firstNameTextField
        let firstNameTooltip = self.firstNameTooltip
        
        let lastNameField = self.lastNameTextField
        let lastNameTooltip = self.lastNameTooltip
        
        let emailField = self.emailTextField
        let emailTooltip = self.emailTooltip
        
        weak var weakViewModel = viewModel
        
        firstNameField?.rx
            .controlEvent([.editingDidEndOnExit, .editingDidEnd])
            .bind {
                firstNameTooltip?.text = weakViewModel?.validate(name: firstNameField?.text) == false ? "not valid" : ""
            }
            .disposed(by: self)
        
        lastNameField?.rx
            .controlEvent([.editingDidEndOnExit, .editingDidEnd])
            .bind {
                lastNameTooltip?.text = weakViewModel?.validate(name: lastNameField?.text) == false ? "not valid" : ""
            }
            .disposed(by: self)
        
        emailField?.rx
            .controlEvent([.editingDidEndOnExit, .editingDidEnd])
            .bind {
                emailTooltip?.text = weakViewModel?.validate(email: emailField?.text) == false ? "not valid" : ""
            }
            .disposed(by: self)
    }
}
