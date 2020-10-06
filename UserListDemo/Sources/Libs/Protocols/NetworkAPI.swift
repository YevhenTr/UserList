//
//  NetworkAPI.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

protocol NetworkAPI {
    
    var defaultURLComponents: URLComponents { get }
    var defaultURLQueryItems: [URLQueryItem] { get }
    var defaultHTTPHeader: [String: String] { get }
}
