//
//  BaseViewModel.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

class BaseViewModel<Event>: NSObject, UnlockHandable {
    
    // MARK: - Properties

    public let eventHandler: Handler<Event>
    
    public var lockHandler: EmptyAction?
    public var unlockHandler: EmptyAction?
    
    // MARK: - Init and Deinit
    
    init(eventHandler: @escaping Handler<Event>) {
        self.eventHandler = eventHandler
        
        super.init()
    }

    deinit {
        debugPrint("deinit: \(String(describing: type(of: self)))")
    }
}

