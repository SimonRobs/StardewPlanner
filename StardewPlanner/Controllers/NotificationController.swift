//
//  NotificationController.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-09.
//

import Foundation

class NotificationController {
    
    static let instance = NotificationController()

    func post(name: Notification.Name, object: Any?) {
        NotificationCenter.default.post(Notification(name: name, object: object))
    }
    
    func subscribe(observer: Any, name:Notification.Name, callbackSelector: Selector, object: Any?) {
        NotificationCenter.default.addObserver(observer, selector: callbackSelector, name: name, object: object)
    }

    func unsubscribe(observer: Any) {
        NotificationCenter.default.removeObserver(observer)
    }
}
