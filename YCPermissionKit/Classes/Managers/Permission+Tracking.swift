//
//  Permission+Tracking.swift
//  YCPermissionKit
//
//  Created by Xyy on 2021/5/12.
//

import AppTrackingTransparency
import AdSupport

extension PermissionProvider {
    
    public static let tracking: PermissionProvider = .init(TrackingManager())
}

struct TrackingManager: Permissionable {
    
    var status: PermissionStatus {
        if #available(iOS 14, *) {
            switch _status {
            case .authorized:       return .authorized
            case .denied:           return .denied
            case .restricted:       return .disabled
            case .notDetermined:    return .notDetermined
            @unknown default:       return .invalid
            }
            
        } else {
            return ASIdentifierManager.shared().isAdvertisingTrackingEnabled ? .authorized : .denied
        }
    }
    
    var name: String { return "Tracking" }
    
    var usageDescriptions: [String] {
        return ["NSUserTrackingUsageDescription"]
    }
    
    @available(iOS 14, *)
    private var _status: ATTrackingManager.AuthorizationStatus {
        return ATTrackingManager.trackingAuthorizationStatus
    }
    
    func request(_ сompletion: @escaping () -> Void) {
        guard status == .notDetermined else {
            сompletion()
            return
        }
        
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { _ in
                DispatchQueue.main.async {
                    сompletion()
                }
            }
            
        } else {
            сompletion()
        }
    }
}
