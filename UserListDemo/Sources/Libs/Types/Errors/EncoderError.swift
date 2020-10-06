//
//  EncoderError.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

enum EncoderError: Error {

    case invalidModel
}

extension EncoderError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .invalidModel:
            return NSLocalizedString("Unable to encode model object.", comment: "invalidModel")
        }
    }
}
