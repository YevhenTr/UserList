//
//  NameInputView.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 07.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

final class NameInputView: InputView {

    // MARK: - Public

    override func configure() {
        super.configure()

        self.inputTextField?.autocapitalizationType = .sentences
        self.inputTextField?.autocorrectionType = .no
        self.keyboardType = .alphabet
        
        self.rules = [.notEmpty, .inRange, .onlyLetters]
    }
}
