//
//  InputView.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 07.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class InputView: UIView {
    
    // MARK: - Properties
    
    public let inputFieldView = FieldView(frame: .zero)
    
    public let isValid = BehaviorRelay<Bool>(value: true)
    public let isEmpty = BehaviorRelay<Bool>(value: true)

    public var validator: ValidatorType = Validator()
    
    public lazy var titleLabel = self.inputFieldView.titleLabel
    public lazy var inputTextField = self.inputFieldView.inputTextField
    public lazy var tooltipLabel = self.inputFieldView.tooltipLabel
    
    public var text: String? {
        get { return self.inputTextField?.text }
        set { self.inputTextField?.text = newValue }
    }
    
    public var titleText: String? {
        get { return self.titleLabel?.text }
        set { self.titleLabel?.text = newValue }
    }
    
    public var placeholder: String? {
        get { return self.inputTextField?.attributedPlaceholder?.string }
        set { self.inputTextField?.placeholder = newValue }
    }
    
    public var keyboardType: UIKeyboardType? {
        get { return self.inputTextField?.keyboardType }
        set { self.inputTextField?.keyboardType = newValue ?? .default }
    }
    
    public var rules = [Rule]()
    
    // MARK: - Init and Deinit
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configure()
        self.bindInputField()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configure()
        self.bindInputField()
    }
    
    // MARK: - Public
    
    open func configure() {
        self.backgroundColor = .systemBackground
        self.titleText = ""
        self.tooltipLabel?.text = ""
        
        let inputContainer = self.inputFieldView
        inputContainer.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(inputContainer)
        NSLayoutConstraint.activate([
            inputContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            inputContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            inputContainer.topAnchor.constraint(equalTo: self.topAnchor),
            inputContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    open func bindInputField() {
        let inputField = self.inputTextField
        let validator = self.validator
        let rules = self.rules
        
        weak var weakSelf = self
        
        inputField?.rx
            .text.orEmpty
            .bind { text in
                weakSelf?.isEmpty.accept(text.isEmpty)
            }
            .disposed(by: self)

        
        inputField?.rx
            .controlEvent([.editingChanged, .editingDidEndOnExit, .editingDidEnd])
            .bind {
                guard let text = inputField?.text else { return }
                let errorMessage = validator.check(text: text, with: rules)

                weakSelf?.isValid.accept(errorMessage == nil)
                weakSelf?.tooltipLabel?.text = errorMessage
            }
            .disposed(by: self)
    }
    

    //  force rechek fields end refresh state isValid/isEmpt
    public func refreshStates() {
        guard let text = self.text else { return }
        
        self.isEmpty.accept(text.isEmpty)
        self.isValid.accept(validator.check(text: text, with: self.rules) == nil)
    }
}
