//
//  Validator.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 07.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

class Validator {
    
    class func validate(text: String, with rules: [Rule]) -> String? {
        return rules
            .compactMap { $0.check(text) }
            .first
    }
}

struct Rule {
    
    // return nil if matches, error message otherwise
    
    let check: (String) -> String?

    // predefined rules
    
    static let notEmpty = Rule(check: { string in
        return string.isEmpty ? "Must not be empty" : nil
    })
    
    static let email = Rule(check: { string in
        let regex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: string) ? nil : "Must have valid email"
    })
    
    static let countryCode = Rule(check: { string in
        let regex = #"^\+\d+.*"#
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: string) ? nil : "Must have prefix country code"
    })
    
    // min 3, max 24 character
    static let inRange = Rule(check: { string in
        let stringLength = string
            .trimmingCharacters(in: .whitespaces)
            .count
        
        let isValid = stringLength >= 3 && stringLength <= 24
        
        return isValid ? nil : "Must have minimum 3, maximum 24 symbols"
    })
    
    static let onlyLetters = Rule(check: { string in
        let filtered = string
            .trimmingCharacters(in: .whitespaces)
            .filter { Rule.notLetters.contains(character: $0) }
        
        let isValid = filtered.isEmpty
        
        return isValid ? nil : "Must contain only letters"
    })
    
    private static let notLetters: CharacterSet = NSCharacterSet.letters.inverted
}
