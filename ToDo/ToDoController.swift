//
//  ToDoController.swift
//  ToDo
//
//  Created by Greg Alton on 1/27/19.
//  Copyright © 2019 Greg Alton. All rights reserved.
//

import UIKit

class ToDoController: UITableViewController {
    
    var items = ["Shop for Groceries", "Eat Out", "Watch TV", "Fall Asleep"]

    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "ToDo"
    }
    
    //mark - TableView Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        itemCell.textLabel?.text = items[indexPath.row]
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
    
    //mark - Add Items
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        var localTextField = UITextField()
        let alert = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //the resulting action
            print("adding item: ", localTextField.text)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new todo"
            localTextField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

