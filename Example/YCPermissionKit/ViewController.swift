//
//  ViewController.swift
//  YCPermissionKit
//
//  Created by Loveying on 08/25/2020.
//  Copyright (c) 2020 Loveying. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var list: [String] = [
        "相机权限",
        "相册权限",
        "日历权限",
        "提醒权限",
        "联系人权限",
        "语音权限",
        "动作权限",
        "媒体权限",
        "Siri权限",
        "麦克风权限",
        "通知权限",
        "位置权限"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "PermissionKitDemo"
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        )
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let mode: Permission.Mode
        switch indexPath.row {
        case 0: // 相机权限
            mode = .camera
            
        case 1: // 相册权限
            mode = .photos
            
        case 2: // 日历权限
            mode = .calendar
            
        case 3: // 提醒权限
            mode = .reminder
            
        case 4: // 联系人权限
            mode = .contacts
            
        case 5: // 语音权限
            mode = .speech
            
        case 6: // 动作权限
            mode = .motion
            
        case 7: // 媒体权限
            mode = .media
            
        case 8: // Siri权限
            mode = .siri
            
        case 9: // 麦克风权限
            mode = .microphone
            
        case 10: // 通知权限
            mode = .notification
            
        case 11: // 位置权限
            mode = .location(.whenInUse)
        case 12: // 追踪权限
            mode = .tracking
        default:
            mode = .camera
        }
        
        print("isAuthorized: \(Permission.isAuthorized(mode))")
        print("request ============")
        Permission.request(mode) { (result) in
            print("isAuthorized: \(Permission.isAuthorized(mode))")
            print("end ================")
        }
    }
}
