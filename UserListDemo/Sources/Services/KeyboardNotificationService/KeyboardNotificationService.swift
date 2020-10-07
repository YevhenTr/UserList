//
//  KeyboardNotificationService.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 07.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

class KeyboardNotificationsService {
    
    enum KeyboardState {
        case visible(endFrame: CGRect, duration: Double)
        case hidden(endFrame: CGRect, duration: Double)
    }
    
    // MARK: - Properties
    
    public var eventHandler: Handler<KeyboardState>?
    
    private var isKeyboardHidden = true
    
    // MARK: - Initialization and Deallocation
    
    deinit {
        self.unregisterNotifications()
    }
    
    init(_ eventHandler: Handler<KeyboardState>? = nil) {
        self.eventHandler = eventHandler
        self.registerNotifications()
    }
    
    // MARK: - Private methods
    
    private func registerNotifications() {
        let notificationCenter = NotificationCenter.default
        [UIWindow.keyboardDidShowNotification, UIWindow.keyboardWillHideNotification]
            .forEach {
            notificationCenter.addObserver(self,
                                           selector: #selector(process(notification:)),
                                           name: $0,
                                           object: nil)
        }
    }
    
    private func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func process(notification: Notification) {
        let isShow = UIWindow.keyboardDidShowNotification == notification.name
        
        if isShow == self.isKeyboardHidden {  //  sync notification and current state
            let endFrame = notification.userInfo?[UIWindow.keyboardFrameEndUserInfoKey] as? CGRect ?? CGRect.zero
            let duration = notification.userInfo?[UIWindow.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
            
            self.isKeyboardHidden = !isShow
            self.eventHandler?(isShow ? .visible(endFrame: endFrame, duration: duration)
                : .hidden(endFrame: .zero, duration: duration))
        }
    }
}
