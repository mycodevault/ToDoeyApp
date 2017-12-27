//
//  ViewController.swift
//  ToDoey
//
//  Created by MBP on 27/12/2017.
//  Copyright © 2017 MBP. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    var itemArray = [Item]()
    
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let newItem1 = Item()
        newItem1.title = "a"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "b"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "c"
        itemArray.append(newItem3)
       
        
        if let retrievedItemsArray = defaults.array(forKey: "toDoListArrayKey") as? [Item] {
            itemArray = retrievedItemsArray
        }
    }
    
    //MARK:- TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //how to display cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "protoCell", for: indexPath)
        
        let currentItem  = itemArray[indexPath.row]
        
        cell.textLabel?.text = currentItem.title
        
        //ternary =>
        //value = condition ? value if true : value if false
        cell.accessoryType = currentItem.done ? .checkmark : .none
        

        
        return cell
    }
    
    //MARK:- TableView Delegate Methods
    
    //tell me what row was selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        //print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
       tableView.reloadData()
        
        
        
        //flash when cell de-selected
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK:- Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textFieldLocal = UITextField()
        
        let alertVC = UIAlertController(title: "Add New", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add item button on the alertVC
        
           let itemToAdd = Item()
            itemToAdd.title = textFieldLocal.text!
           self.itemArray.append(itemToAdd)//need to filter for empty textfield
            
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

























