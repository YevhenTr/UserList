//
//  UserListAPI.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

struct UserListAPI: NetworkAPI {
    
    // MARK: - Subtypes
    
    private enum Constant { //https://cua-users.herokuapp.com/
        
        static let scheme = "https"
        static let host = "cua-users.herokuapp.com"
        static let path = ""
    }
    
    // MARK: - Properties
    
    let defaultURLComponents: URLComponents
    let defaultURLQueryItems: [URLQueryItem]
    let defaultHTTPHeader: [String: String]
    
    // MARK: - Init and Deinit
    
    init() {
        var components = URLComponents()
        components.scheme = Constant.scheme
        components.host = Constant.host
        
        self.defaultURLComponents = components
        self.defaultURLQueryItems = []
        
        self.defaultHTTPHeader = [
            "Content-Type" : "application/json"
        ]
    }
}
