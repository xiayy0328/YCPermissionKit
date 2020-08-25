//
//  PermissionProvider.swift
//  PermissionKitDemo
//
//  Created by Xyy on 2020/8/24.
//  Copyright © 2020 sany. All rights reserved.
//

import UIKit

public class PermissionProvider {
    
    let manager: () -> Permissionable
    
    /// 是否授权
    public var isAuthorized: Bool {
        return manager().status == .authorized
    }
    
    /// 初始化
    init(_ manager: @escaping @autoclosure () -> Permissionable) {
        self.manager = manager
    }
    
    /// 别名
    public var alias: (() -> String)?
    
    /// 请求授权
    /// - Parameter сompletion: 结果回调
    public func request(_ сompletion: @escaping (Bool) -> Void) {
        let manager = self.manager()
        manager.checkUsageDescriptions()
        manager.request {
            сompletion(manager.status == .authorized)
        }
    }
    
}
