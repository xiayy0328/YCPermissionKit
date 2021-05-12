//
//  PermissionProtocol.swift
//  PermissionKitDemo
//
//  Created by Xyy on 2020/8/24.
//  Copyright © 2020 sany. All rights reserved.
//

import Foundation

/// 定义授权的状态
public enum PermissionStatus {
    case authorized
    case denied
    case disabled
    case notDetermined
    case invalid
    
    var name: String {
        switch self {
        case .authorized:               return "Authorized"
        case .denied:                   return "Denied"
        case .disabled:                 return "Disabled"
        case .notDetermined:            return "Not Determined"
        case .invalid:                  return "Invalid"
        }
    }
}

/// 定义授权的协议
protocol Permissionable {
    var status: PermissionStatus { get }
    var name: String { get }
    var usageDescriptions: [String] { get }
    func request(_ сompletion: @escaping () -> Void)
}

extension Permissionable {
    /// 检查info.plist文件是否配置相关权限
    @discardableResult
    func checkUsageDescriptions() -> Bool {
        for key in usageDescriptions {
            guard let _ = Bundle.main.object(forInfoDictionaryKey: key) else {
                fatalError("⚠️ Warning - \(key) for \(name) not found in Info.plist")
            }
        }
        return true
    }
}
