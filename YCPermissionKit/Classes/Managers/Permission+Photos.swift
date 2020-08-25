//
//  Permission+Photos.swift
//  PermissionKitDemo
//
//  Created by Xyy on 2020/8/24.
//  Copyright © 2020 sany. All rights reserved.
//

import Photos

extension PermissionProvider {
    
    public static let photos: PermissionProvider = .init(PhotosManager())
}

struct PhotosManager: Permissionable {
    
    var status: PermissionStatus {
        switch _status {
        case .authorized:       return .authorized
        case .denied:           return .denied
        case .restricted:       return .disabled
        case .notDetermined:    return .notDetermined
        @unknown default:       return .invalid
        }
    }
    
    var name: String { return "Photo Library" }
    
    var usageDescriptions: [String] {
        return ["NSPhotoLibraryUsageDescription",
                "NSPhotoLibraryAddUsageDescription"]
    }
    
    private var _status: PHAuthorizationStatus {
        return PHPhotoLibrary.authorizationStatus()
    }
    
    func request(_ сompletion: @escaping () -> Void) {
        guard status == .notDetermined else {
            сompletion()
            return
        }
        
        PHPhotoLibrary.requestAuthorization { finished in
            DispatchQueue.main.async {
                сompletion()
            }
        }
    }
}
