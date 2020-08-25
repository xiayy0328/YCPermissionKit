//
//  Permission+Contacts.swift
//  PermissionKitDemo
//
//  Created by Xyy on 2020/8/24.
//  Copyright © 2020 sany. All rights reserved.
//

import Contacts

extension PermissionProvider {
    public static let contacts: PermissionProvider = .init(ContactsManager())
}

struct ContactsManager: Permissionable {
    var status: PermissionStatus {
        switch _status {
        case .authorized:       return .authorized
        case .denied:           return .denied
        case .restricted:       return .disabled
        case .notDetermined:    return .notDetermined
        @unknown default:       return .invalid
        }
    }
    
    var name: String { return "Contacts" }
    
    var usageDescriptions: [String] {
        return ["NSContactsUsageDescription"]
    }
    
    private var _status: CNAuthorizationStatus {
        return CNContactStore.authorizationStatus(for: .contacts)
    }
    
    func request(_ сompletion: @escaping () -> Void) {
        guard status == .notDetermined else {
            сompletion()
            return
        }
        
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            DispatchQueue.main.async {
                сompletion()
            }
        }
    }
}
