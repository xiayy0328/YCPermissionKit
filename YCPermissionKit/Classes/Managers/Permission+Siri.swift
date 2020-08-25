//
//  Permission+Siri.swift
//  PermissionKitDemo
//
//  Created by Xyy on 2020/8/24.
//  Copyright © 2020 sany. All rights reserved.
//

import Intents

extension PermissionProvider {
    
    public static let siri: PermissionProvider = .init(SiriManager())
}

struct SiriManager: Permissionable {
    
    var status: PermissionStatus {
        switch _status {
        case .authorized:       return .authorized
        case .denied:           return .denied
        case .restricted:       return .disabled
        case .notDetermined:    return .notDetermined
        @unknown default:       return .invalid
        }
    }
    
    var name: String { return "Siri" }
    
    var usageDescriptions: [String] {
        return ["NSSiriUsageDescription"]
    }
    
    private var _status: INSiriAuthorizationStatus {
        return INPreferences.siriAuthorizationStatus()
    }
    
    func request(_ сompletion: @escaping () -> Void) {
        guard status == .notDetermined else {
            сompletion()
            return
        }
        
        INPreferences.requestSiriAuthorization { (status) in
            DispatchQueue.main.async {
                сompletion()
            }
        }
    }
}
