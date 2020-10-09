//
//  Validator.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 07.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

protocol ValidatorType {
    
    func check(text: String, with rules: [Rule]) -> String?
}

class Validator: ValidatorType {
    
    // MARK: - Public
    
    public func check(text: String, with rules: [Rule]) -> String? {
        return rules
            .compactMap { $0.check(text) }
            .first
    }
}

struct Rule {
    
    // MARK: - Class Properties
    
    private static let notLetters: CharacterSet = NSCharacterSet.letters.inverted
    
    // MARK: - Class Methods
    
    static let notEmpty = Rule(check: { string in
        return string.isEmpty ? "Must not be empty" : nil
    })
    
    static let email = Rule(check: { string in
        let regex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return predicate.evaluate(with: string) ? nil : "Must have valid email"
    })
    
    // min 3, max 24 character
    static let inRange = Rule(check: { string in
        let min = 3
        let max = 24
        let stringLength = string
            .trimmingCharacters(in: .whitespaces)
            .count
        
        let isValid = stringLength >= min && stringLength <= max
        
        return isValid ? nil : "Must have minimum \(min), maximum \(max) symbols"
    })
    
    static let onlyLetters = Rule(check: { string in
        let filtered = string
            .trimmingCharacters(in: .whitespaces)
            .filter { Rule.notLetters.contains(character: $0) }
        
        let isValid = filtered.isEmpty
        
        return isValid ? nil : "Must contain only letters"
    })
    
    static let http = Rule(check: { string in
        let isValid = URL(string: string) != nil && string.hasPrefix("http")
        
        return isValid ? nil : "Must have valid http(s) link"
    })
    
    // MARK: - Properties
    // return nil if matches, error message otherwise
    
    let check: (String) -> String?
}
