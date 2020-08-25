//
//  Permission+Notification.swift
//  PermissionKitDemo
//
//  Created by Xyy on 2020/8/24.
//  Copyright © 2020 sany. All rights reserved.
//

import UIKit
import UserNotifications

extension PermissionProvider {
    
    public static let notification: PermissionProvider = .init(NotificationManager())
}

struct NotificationManager: Permissionable {
    
    private static var status: UNAuthorizationStatus?
    private static let observer: Void = {
        NotificationCenter.default.addObserver(
            forName: UIApplication.willEnterForegroundNotification,
            object: nil,
            queue: .main,
            using: { _ in
                status = nil
                UNUserNotificationCenter.current().getNotificationSettings { value in
                    DispatchQueue.main.async {
                        status = value.authorizationStatus
                    }
                }
            }
        )
    } ()
    
    init() {
        NotificationManager.observer
    }
    
    var status: PermissionStatus {
        switch _status {
        case .authorized, .provisional:     return .authorized
        case .denied:                       return .denied
        case .notDetermined:                return .notDetermined
        @unknown default:                   return .invalid
        }
    }
    
    var name: String { return "Notification" }
    
    var usageDescriptions: [String] {
        return []
    }
    
    private var _status: UNAuthorizationStatus {
        guard let status = NotificationManager.status else {
            var settings: UNNotificationSettings?
            let semaphore = DispatchSemaphore(value: 0)
            DispatchQueue.global().async {
                UNUserNotificationCenter.current().getNotificationSettings { value in
                    settings = value
                    semaphore.signal()
                }
            }
            semaphore.wait()
            NotificationManager.status = settings?.authorizationStatus
            return NotificationManager.status ?? .denied
        }
        return status
    }
    
    func request(_ сompletion: @escaping () -> Void) {
        guard status == .notDetermined else {
            сompletion()
            return
        }
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge, .alert, .sound]) {
            (granted, error) in
            center.getNotificationSettings { value in
                DispatchQueue.main.async {
                    NotificationManager.status = value.authorizationStatus
                    сompletion()
                }
            }
        }
        
        UIApplication.shared.registerForRemoteNotifications()
    }
}

fileprivate extension UserDefaults {
    
    var isRequestedNotifications: Bool {
        get { return bool(forKey: "Permission.RequestedNotifications") }
        set { set(newValue, forKey: "Permission.RequestedNotifications") }
    }
}
