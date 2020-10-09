//
//  UnlockHandable.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 09.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

protocol UnlockHandable: class {
    
    var lockHandler: EmptyAction? { get set }
    var unlockHandler: EmptyAction? { get set }
}
