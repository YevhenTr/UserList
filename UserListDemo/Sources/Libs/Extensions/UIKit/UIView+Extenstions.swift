//
//  UIView+Extenstions.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

extension UIView {
    
    @discardableResult
    func set(cornerRadius: CGFloat) -> Self {
        self.layer.cornerRadius = cornerRadius
        
        return self
    }
    
    @discardableResult
    func set(borderWidth: CGFloat) -> Self {
        self.layer.borderWidth = borderWidth
        
        return self
    }
    
    @discardableResult
    func set(borderColor: UIColor) -> Self {
        self.layer.borderColor = borderColor.cgColor
        
        return self
    }
    
    func addHideKeyboardGeasture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
        self.endEditing(true)
    }
}
