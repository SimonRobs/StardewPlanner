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

    func subscribe(name:Notification.Name, object: Any?, using: @escaping @Sendable (Notification) -> Void) {
        NotificationCenter.default.addObserver(forName: name, object: nil, queue: nil, using: using)
    }

    func unsubscribe(observer: Any) {
        NotificationCenter.default.removeObserver(observer)
    }
}
