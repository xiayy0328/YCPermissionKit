//
//  Permission.swift
//  YCPermissionKit_Example
//
//  Created by Xyy on 2020/8/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import YCPermissionKit

enum Permission {
    enum Mode {
        case camera
        case photos
        case calendar
        case reminder
        case contacts
        case speech
        case motion
        case media
        case siri
        case microphone
        case location(PermissionProvider.LocationType)
        case notification
        
        var provider: PermissionProvider {
            let mode: PermissionProvider
            switch self {
            case .camera:
                mode = PermissionProvider.camera
                mode.alias = { "相机" }
                
            case .photos:
                mode = PermissionProvider.photos
                mode.alias = { "相册" }
                
            case .calendar:
                mode = PermissionProvider.calendar
                mode.alias = { "日历" }
                
            case .reminder:
                mode = PermissionProvider.reminder
                mode.alias = { "提醒" }
                
            case .contacts:
                mode = PermissionProvider.contacts
                mode.alias = { "联系人" }
                
            case .speech:
                mode = PermissionProvider.speech
                mode.alias = { "语音" }
                
            case .motion:
                mode = PermissionProvider.motion
                mode.alias = { "动作" }
                
            case .media:
                mode = PermissionProvider.media
                mode.alias = { "媒体库" }
                
            case .siri:
                mode = PermissionProvider.siri
                mode.alias = { "Siri" }
                
            case .microphone:
                mode = PermissionProvider.microphone
                mode.alias = { "麦克风" }
                
            case .location(let value):
                mode = PermissionProvider.location(value)
                mode.alias = { "定位" }
                
            case .notification:
                mode = PermissionProvider.notification
                mode.alias = { "通知" }
            }
            return mode
        }
    }
    
    public static func isAuthorized(_ mode: Mode) -> Bool {
        return mode.provider.isAuthorized
    }
    
    public static func request(_ mode: Mode, with сompletion: @escaping (Bool) -> Void) {
        mode.provider.request(сompletion)
    }
    
    
}
