//
//  Functions.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

public typealias Handler<T> = (T) -> ()
public typealias Completion<T> = (T) -> ()
public typealias Action<T> = (T) -> ()

public typealias EmptyAction = () -> ()

public func toString(_ cls: AnyClass) -> String {
    return String(describing: cls)
}

func libraryFolderPath() -> String {
    return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first?.path ?? ""
}
