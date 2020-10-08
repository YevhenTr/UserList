//
//  EmailInputView.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 07.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

final class EmailInputView: InputView {
    
    // MARK: - Public
    
    override func configure() {
        super.configure()
        
        self.inputTextField?.autocapitalizationType = .none
        self.inputTextField?.autocorrectionType = .no
        self.keyboardType = .emailAddress
        
        self.rules = [.notEmpty, .email]
    }
}
