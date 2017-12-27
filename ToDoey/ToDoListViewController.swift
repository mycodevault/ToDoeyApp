//
//  ViewController.swift
//  ToDoey
//
//  Created by MBP on 27/12/2017.
//  Copyright © 2017 MBP. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    var itemArray = ["a","b","c"]
    
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.array(forKey: "toDoListArrayKey") as? [String] {
            itemArray = items
        }
    }
    
    //MARK:- TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "protoCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK:- TableView Delegate Methods
    
    //tell me what row was selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        print(itemArray[indexPath.row])
        
        //add tick on selection only if there is no checkmark already
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        
        //flash when cell selected
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK:- Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textFieldLocal = UITextField()
        
        let alertVC = UIAlertController(title: "Add New", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add item button on the alertVC
        
           
           self.itemArray.append(textFieldLocal.text!)//need to filter for empty textfield
            
           self.defaults.set(self.itemArray, forKey: "toDoListArrayKey")
            
           self.tableView.reloadData() //the reload takes a LONG TIME.....must wait
           print("reload triggered")
            
        
        }
        
        alertVC.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textFieldLocal = alertTextField

        }
        alertVC.addAction(action)
        
        present(alertVC, animated: true, completion: nil)
        
    }
    
}

























