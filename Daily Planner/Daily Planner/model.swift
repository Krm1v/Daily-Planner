//
//  model.swift
//  Daily Planner
//
//  Created by Владислав Баранкевич on 10.03.2021.
//

import Foundation

var ToDoItems: [[String: Any]] = [["Name": "Call mom", "isCompleted": false], ["Name": "Buy a bread", "isCompleted": false], ["Name": "Drink cola", "isCompleted": false]]

func addItem(nameItem: String, isCompleted: Bool = false) -> Void {
    ToDoItems.append(["Name": nameItem, "isCompleted": false])
    saveData()
}

func removeItem(at index: Int) -> Void {
    ToDoItems.remove(at: index)
    saveData()
}

func saveData() -> Void {
}

func loadData() -> Void {
    
}
