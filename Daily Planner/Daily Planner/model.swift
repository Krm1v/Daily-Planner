//
//  model.swift
//  Daily Planner
//
//  Created by Владислав Баранкевич on 10.03.2021.
//

import Foundation

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
    
}

func removeItem(at index: Int) -> Void {
    ToDoItems.remove(at: index)
    
}

func changeState(at item: Int) -> Bool {
    ToDoItems[item]["isCompleted"] = !(ToDoItems[item]["isCompleted"] as! Bool)
    return ToDoItems[item]["isCompleted"] as! Bool
    }

func moveItem(fromIndex: Int, toIndex: Int) {
let from = ToDoItems[fromIndex]
ToDoItems.remove(at: fromIndex)
ToDoItems.insert(from, at: toIndex)
}

