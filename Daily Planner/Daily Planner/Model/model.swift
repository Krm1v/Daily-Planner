//
//  model.swift
//  Daily Planner
//
//  Created by Владислав Баранкевич on 10.03.2021.
//

import Foundation
import UserNotifications
import UIKit

var ToDoItems: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "ToDoDataKey")
        UserDefaults.standard.synchronize()
    }
    get {
        if let array = UserDefaults.standard.array(forKey: "ToDoDataKey") as? [[String: Any]] {
            return array
        } else {
            return []
        }
    }
}

func addItem(nameItem: String, isCompleted: Bool = false) -> Void {
    ToDoItems.append(["Name": nameItem, "isCompleted": false])
    setBadge()
}

func removeItem(at index: Int) -> Void {
    ToDoItems.remove(at: index)
    setBadge()
}

func changeState(at item: Int) -> Bool {
    ToDoItems[item]["isCompleted"] = !(ToDoItems[item]["isCompleted"] as! Bool)
    setBadge()
    return ToDoItems[item]["isCompleted"] as! Bool
    
}

func moveItem(fromIndex: Int, toIndex: Int) {
let from = ToDoItems[fromIndex]
ToDoItems.remove(at: fromIndex)
ToDoItems.insert(from, at: toIndex)
}

func requestForNotifications() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { (isEnabled, error) in
        if isEnabled {
            print("Accepted")
        } else {
            print("Denied")
        }
    }
}

func setBadge() {
    var totalBadgeCount = 0
    for item in ToDoItems {
        if (item["isCompleted"] as? Bool) == false {
            totalBadgeCount += 1
        }
    }
    UIApplication.shared.applicationIconBadgeNumber = totalBadgeCount
}
