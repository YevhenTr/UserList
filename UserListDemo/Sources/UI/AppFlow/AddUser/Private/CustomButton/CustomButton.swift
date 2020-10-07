//
//  CustomButton.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 08.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

final class CustomButton: UIButton {
    
    var normalBackgroundColor = UIColor.systemBlue
    var disabledBackgroundColor = UIColor.systemGray
    
    override var isEnabled: Bool {
        get {
            super.isEnabled
        }
        set(isEnabled) {
            self.backgroundColor = isEnabled ? self.normalBackgroundColor : self.disabledBackgroundColor
            super.isEnabled = isEnabled
        }
    }
}
