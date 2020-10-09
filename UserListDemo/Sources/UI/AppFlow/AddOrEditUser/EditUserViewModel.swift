//
//  EditUserViewModel.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 08.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

enum EditUserEvent {

}

class EditUserViewModel: InputFormViewModel {
    
    // MARK: - Public
    
    override func save(newUser: NewUserModel) {
//        guard let id = self.user?.id else { return }
        
//        self.networking.edit(id: id, newUser: newUser) { [weak self] result in
//            switch result {
//            case .failure(let error):
//                self?.eventHandler(.error(error))
//            case .success:
//                self?.eventHandler(.back)
//            }
//        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) {
            debugPrint("error or succes with newUser \(newUser.user.firstName)")
            
            DispatchQueue.main.async {
                self.eventHandler(.back)
            }
        }
    }
}

