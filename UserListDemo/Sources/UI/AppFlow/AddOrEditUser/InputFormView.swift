//
//  InputFormView.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import Kingfisher

class InputFormView: SpinnableView<InputFormViewModel> {

    // MARK: - Subtypes

    typealias Text = AppTextConstants.UserForm
    
    private enum Constant {
        static let cornerRadius: CGFloat = 5
        static let borderWidth: CGFloat = 1
    }
    
    // MARK: - Properties
    
    @IBOutlet var contentScrollView: UIScrollView?

    @IBOutlet var firstNameInputView: NameInputView?
    @IBOutlet var lastNameInputView: NameInputView?
    @IBOutlet var emailInputView: EmailInputView?
    @IBOutlet var urlInputView: URLInputView?

    @IBOutlet var userPhotoContainerView: UIStackView?
    @IBOutlet var userPhotoImageView: UIImageView?
    
    @IBOutlet var addUserButton: CustomButton?
    
    private lazy var bottomInset = UIApplication.shared.windows
        .filter {$0.isKeyWindow}
        .first?
        .safeAreaInsets.bottom
        ?? 0
    
    private let isModelChanged = BehaviorRelay(value: true)
    private let placeholderImage = UIImage(named: "userphoto_placeholder_image")

    private var downloadImageTask: DownloadTask?
    
    // MARK: - Init and Deinit
    
    deinit {
        self.downloadImageTask?.cancel()
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configure()
        self.bindInputFields()
    }
      
    // MARK: - Public

    override public func fill(with viewModel: InputFormViewModel) {
        super.fill(with: viewModel)
        
        self.bindKeyboardService(with: viewModel)
        self.bindButtons(with: viewModel)
        
        if let user = viewModel.user {
            self.addUserButton?.setTitle(Text.editUserButton, for: .normal)
            
            self.urlInputView?.text = user.imageURL
            self.userPhotoContainerView?.isHidden = false
            self.userPhotoImageView?.kf
                .setImage(with: URL(string: user.imageURL), placeholder: self.placeholderImage)
            
            //  should be start after all additional tuning
            self.bind(user: user, viewModel: viewModel)
        }
    }
    
    // MARK: - Private
    
    private func configure() {
        self.addHideKeyboardGeasture()
        
        self.firstNameInputView?.titleText = Text.firstNameTitle
        self.lastNameInputView?.titleText = Text.lastNameTitle
        self.emailInputView?.titleText = Text.emailTitle
        self.urlInputView?.titleText = Text.photoTitle
        
        self.userPhotoContainerView?.isHidden = true
                
        self.addUserButton?
            .set(cornerRadius: Constant.cornerRadius)
            .setTitle(Text.addUserButton, for: .normal)
        self.addUserButton?.isEnabled = false
    }
    
    private func bindKeyboardService(with viewModel: InputFormViewModel) {
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
    
    private func bindInputFields() {
        guard
            let firstNameValid = self.firstNameInputView?.isValid,
            let lastNameValid = self.lastNameInputView?.isValid,
            let emailValid = self.emailInputView?.isValid
        else { return }
        
        guard
            let firstNameNotEmpty = self.firstNameInputView?.isEmpty.map({ !$0 }),
            let lastNameNotEmpty = self.lastNameInputView?.isEmpty.map({ !$0 }),
            let emailNotEmpty = self.emailInputView?.isEmpty.map({ !$0 })
        else { return }
        
        let allFieldsValid = Observable.combineLatest(firstNameValid, lastNameValid, emailValid) { $0 && $1 && $2 }
        let allFieldsNotEmpty = Observable.combineLatest(firstNameNotEmpty, lastNameNotEmpty, emailNotEmpty) { $0 && $1 && $2 }
        let modelChanged = self.isModelChanged
        
        Observable
            .combineLatest(allFieldsValid, allFieldsNotEmpty, modelChanged) { $0 && $1 && $2 }
            .bind { [weak self] result in
                self?.addUserButton?.isEnabled = result
            }
            .disposed(by: self)
    }
    
    private func bindButtons(with viewModel: InputFormViewModel) {
        self.addUserButton?.rx.tap
            .bind { [weak self, weak viewModel] _ in
                if let newUser = self?.createUserModel() {
                    viewModel?.save(newUser: newUser)
                } else {
                    viewModel?.show(error: ParserError.invalidData)
                }
            }
            .disposed(by: self)
    }
    
    private func bind(user: UserModel, viewModel: InputFormViewModel) {
        guard
            let firstNameField = self.firstNameInputView?.inputTextField,
            let lastNameField = self.lastNameInputView?.inputTextField,
            let emailField = self.emailInputView?.inputTextField,
            let urlField = self.urlInputView?.inputTextField
        else { return }
        
        firstNameField.text = user.firstName
        lastNameField.text = user.lastName
        emailField.text = user.email
        
        [self.firstNameInputView, self.lastNameInputView, self.emailInputView]
            .compactMap { $0 }
            .forEach { $0.refreshStates() }
                
        let firstNameChanged = firstNameField.rx.text.orEmpty.map { $0 != user.firstName }.asObservable()
        let lastNameChanged = lastNameField.rx.text.orEmpty.map { $0 != user.lastName }.asObservable()
        let emailChanged = emailField.rx.text.orEmpty.map { $0 != user.email }.asObservable()
        let urlChanged = urlField.rx.text.orEmpty.map { $0 != user.imageURL }
        Observable
            .combineLatest(firstNameChanged, lastNameChanged, emailChanged, urlChanged) { $0 || $1 || $2 || $3 }
            .bind { [weak self] in self?.isModelChanged.accept($0) }
            .disposed(by: self)
    }
    
    private func createUserModel() -> NewUserModel? {
        guard
            let firstName = self.firstNameInputView?.text,
            let lastName = self.lastNameInputView?.text,
            let email = self.emailInputView?.text
        else { return nil }
        
        return NewUserModel(firstName: firstName, lastName: lastName, email: email)
    }
}
