//
//  URLInputView.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 09.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

final class URLInputView: InputView {
    
    // MARK: - Subtypes
    
    private enum Constants {
        static let prefix = "https://"
    }
    
    // MARK: - Public
    
    override func configure() {
        super.configure()
        
        self.inputTextField?.autocapitalizationType = .none
        self.inputTextField?.autocorrectionType = .no
        self.text = Constants.prefix
        self.keyboardType = .default
        
        self.rules = []
    }
}
