//
//  Permission+Media.swift
//  PermissionKitDemo
//
//  Created by Xyy on 2020/8/24.
//  Copyright © 2020 sany. All rights reserved.
//

import MediaPlayer

extension PermissionProvider {
    
    public static let media: PermissionProvider = .init(MediaManager())
}

struct MediaManager: Permissionable {
    
    var status: PermissionStatus {
        switch _status {
        case .authorized:       return .authorized
        case .denied:           return .denied
        case .restricted:       return .disabled
        case .notDetermined:    return .notDetermined
        @unknown default:       return .invalid
        }
    }
    
    var name: String { return "Media Library" }
    
    var usageDescriptions: [String] {
        return ["NSAppleMusicUsageDescription"]
    }
    
    private var _status: MPMediaLibraryAuthorizationStatus {
        return MPMediaLibrary.authorizationStatus()
    }
    
    func request(_ сompletion: @escaping () -> Void) {
        guard status == .notDetermined else {
            сompletion()
            return
        }
        
        MPMediaLibrary.requestAuthorization() { status in
            DispatchQueue.main.async {
                сompletion()
            }
        }
    }
}

