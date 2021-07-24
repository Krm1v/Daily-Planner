//
//  TableViewController.swift
//  Daily Planner
//
//  Created by Владислав Баранкевич on 10.03.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    //MARK: - Button actions
    @IBAction func pushToEdit(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tableView.reloadData()
    }
}
    @IBAction func pushToAddAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Create new To-Do", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "New To-Do name"
        }
        
        let alertAction1 = UIAlertAction(title: "Cancel", style: .default) { (alert) in
    }
        let alertAction2 = UIAlertAction(title: "Create", style: .cancel) { (alert) in
        let newItem = alertController.textFields![0].text
            if newItem != "" {
            addItem(nameItem: newItem ?? "New item")
            self.tableView.reloadData()
        }
    }
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ToDoItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let currentItem = ToDoItems[indexPath.row]
        cell.textLabel?.text = currentItem["Name"] as? String
        
        if (currentItem["isCompleted"] as? Bool) == true {
            cell.imageView?.image = #imageLiteral(resourceName: "checkmarkColored")
        } else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = #imageLiteral(resourceName: "empty")
        }
        
        if cell.imageView?.image == #imageLiteral(resourceName: "checkmarkColored") {
            cell.textLabel?.alpha = 0.2
        } else {
            cell.textLabel?.alpha = 1
        }
        
        
//MARK: - isEditing
        if tableView.isEditing {
            cell.imageView?.alpha = 0.5
        } else {
            cell.imageView?.alpha = 1
        }
        return cell
    }

    

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.imageView?.image = #imageLiteral(resourceName: "checkmarkColored")
            tableView.cellForRow(at: indexPath)?.textLabel?.alpha = 0.2
        } else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = #imageLiteral(resourceName: "empty")
            tableView.cellForRow(at: indexPath)?.textLabel?.alpha = 1
        }
    }

    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return .none
        } else {
            return .delete
        }
    }
    
 
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

