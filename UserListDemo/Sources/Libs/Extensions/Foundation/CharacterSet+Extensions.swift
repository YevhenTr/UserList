//
//  CharacterSet+Extensions.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 07.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

extension CharacterSet {

    func contains(character: Character) -> Bool {
        return character.unicodeScalars.allSatisfy { self.contains($0) }
    }
}
