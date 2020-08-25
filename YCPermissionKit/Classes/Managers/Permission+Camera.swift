//
//  Permission+Camera.swift
//  PermissionKitDemo
//
//  Created by Xyy on 2020/8/24.
//  Copyright © 2020 sany. All rights reserved.
//

import AVFoundation

extension PermissionProvider {
    
    public static let camera: PermissionProvider = .init(CameraManager())
    
    public static let microphone: PermissionProvider = .init(MicrophoneManager())
}

struct CameraManager: Permissionable {
    
    var status: PermissionStatus {
        switch _status {
        case .authorized:       return .authorized
        case .denied:           return .denied
        case .restricted:       return .disabled
        case .notDetermined:    return .notDetermined
        @unknown default:       return .invalid
        }
    }
    
    var name: String { return "Camera" }
    
    var usageDescriptions: [String] {
        return ["NSCameraUsageDescription"]
    }
    
    private var _status: AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatus(for: .video)
    }
    
    func request(_ сompletion: @escaping () -> Void) {
        guard status == .notDetermined else {
            сompletion()
            return
        }
        
        AVCaptureDevice.requestAccess(for: .video) { finished in
            DispatchQueue.main.async {
                сompletion()
            }
        }
    }
}

struct MicrophoneManager: Permissionable {
    
    var status: PermissionStatus {
        switch _status {
        case .granted:          return .authorized
        case .denied:           return .denied
        case .undetermined:     return .notDetermined
        @unknown default:       return .invalid
        }
    }
    
    var name: String { return "Microphone" }
    
    var usageDescriptions: [String] {
        return ["NSMicrophoneUsageDescription"]
    }
    
    private var _status: AVAudioSession.RecordPermission {
        return AVAudioSession.sharedInstance().recordPermission
    }
    
    func request(_ сompletion: @escaping () -> Void) {
        guard status == .notDetermined else {
            сompletion()
            return
        }
        
        AVAudioSession.sharedInstance().requestRecordPermission { finished in
            DispatchQueue.main.async {
                сompletion()
            }
        }
    }
}
