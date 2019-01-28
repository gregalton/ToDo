//
//  ToDoController.swift
//  ToDo
//
//  Created by Greg Alton on 1/27/19.
//  Copyright © 2019 Greg Alton. All rights reserved.
//

import UIKit
import CoreData

class ToDoController: UITableViewController {
    
    var items = [ToDoItem]()
    //var items = ["Shop for Groceries", "Eat Out", "Watch TV", "Fall Asleep"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getItems()
    }
    
    //mark - TableView Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        let record = items[indexPath.row]
        itemCell.textLabel?.text = record.title
        return itemCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            print("Deleting Item")
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            PersistentService.context.delete(items[indexPath.row])
            PersistentService.saveContext()
            tableView.reloadData()
        }
    }
    
    //mark - Add Items
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        presentAddItem()
    }
    
    func presentAddItem() {
        var localTextField = UITextField()
        let alert = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //the resulting action
            let entity = NSEntityDescription.entity(forEntityName: "ToDoItem", in: PersistentService.context)
            guard let item = NSManagedObject(entity: entity!, insertInto: PersistentService.context) as? ToDoItem else {return}
            item.title = localTextField.text
            self.saveItem(item: item)
            print("adding item: ", localTextField.text)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new todo"
            localTextField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //mark - CoreData
    func getItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoItem")
        
        do {
            items = try PersistentService.context.fetch(request) as! [ToDoItem]
        } catch {
            fatalError("Failed to fetch list items: \(error)")
        }
        self.tableView.reloadData()
    }
    
    func saveItem(item: ToDoItem) {
        let entity = NSEntityDescription.entity(forEntityName: "ToDoItem", in: PersistentService.context)
        let record = NSManagedObject(entity: entity!, insertInto: PersistentService.context) as? ToDoItem
        record?.title = item.title
        PersistentService.saveContext()
    }
    
}

