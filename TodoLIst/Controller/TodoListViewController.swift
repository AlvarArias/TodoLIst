//
//  ViewController.swift
//  TodoLIst
//
//  Created by Alvar Arias on 2021-07-30.
//  Copyright © 2021 Alvar Arias. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
      
        let newItem = Item()
        newItem.title = "Cortar el pasto"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Cortarme el pelo"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Estudiar SFI"
        itemArray.append(newItem3)
        
  
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
        
        
        
    }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return itemArray.count
    
   }
    
    //MARK Table View Data Source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]

        cell.textLabel?.text = item.title

        // Ternary operator
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }

    //MARK Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK Add new Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todo Item" , message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            // Add a new Activity
            self.itemArray.append(newItem)
            
            //Persisted data
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            // Reaload Tables view data
            self.tableView.reloadData()
            
        }
        
        // Alert configuration
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
}



