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
    
    //file manager = interface to filesystem
    //default filemanager = shared file manager object - singleton - ststatic property
    //the singleton returns an array of urls organised by directory and domain maskz
    //userdomain mask = user own direcory
    
    let dataFilePath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
  
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    
        
        loadItems()
       
        

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
    
     
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
        saveItems()
        
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
            
            self.saveItems()

        
        }
        
        alertVC.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textFieldLocal = alertTextField

        }
        alertVC.addAction(action)
        
        present(alertVC, animated: true, completion: nil)
        
    }
    
    //MARK:- MODEL MANIPULATION METHODS
    
    func saveItems(){
        
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("error encoding item array: \(error)")
        }
        
        
        self.tableView.reloadData() //the reload takes a LONG TIME.....must wait
        
        
    }
    func loadItems(){
        
        if let data = try? Data(contentsOf: dataFilePath!){
        
            let decoder = PropertyListDecoder()
            
            do{
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("error decoding item array: \(error)")
            }
        }
    }
    
}

























