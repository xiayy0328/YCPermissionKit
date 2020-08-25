//
//  Permission+Speech.swift
//  PermissionKitDemo
//
//  Created by Xyy on 2020/8/24.
//  Copyright © 2020 sany. All rights reserved.
//

import Speech

extension PermissionProvider {
    
    public static let speech: PermissionProvider = .init(SpeechManager())
}

struct SpeechManager: Permissionable {
    
    var status: PermissionStatus {
        switch _status {
        case .authorized:       return .authorized
        case .denied:           return .denied
        case .restricted:       return .disabled
        case .notDetermined:    return .notDetermined
        @unknown default:       return .invalid
        }
    }
    
    var name: String { return "Speech" }
    
    var usageDescriptions: [String] {
        return ["NSMicrophoneUsageDescription",
                "NSSpeechRecognitionUsageDescription"]
    }
    
    private var _status: SFSpeechRecognizerAuthorizationStatus {
        return SFSpeechRecognizer.authorizationStatus()
    }
    
    func request(_ сompletion: @escaping () -> Void) {
        guard status == .notDetermined else {
            сompletion()
            return
        }
        
        SFSpeechRecognizer.requestAuthorization { status in
            DispatchQueue.main.async {
                сompletion()
            }
        }
    }
}
