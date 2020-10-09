//
//  FieldView.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 07.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

class FieldView: NibDesignable {
    
    // MARK: - Properties
    
    @IBOutlet var contentContaner: UIView?
    @IBOutlet var contentStackView: UIStackView?
    
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var inputTextField: UITextField?
    @IBOutlet var tooltipLabel: UILabel?
}
