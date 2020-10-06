//
//  SceneDelegate.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var rootCoordinator: RootCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        debugPrint("# willConnect")
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let rootCoordinator = RootCoordinator()
        window.rootViewController = rootCoordinator.navigationController
        window.makeKeyAndVisible()
        
        self.window = window
        self.rootCoordinator = rootCoordinator
    }
}

