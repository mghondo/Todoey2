//
//  CatergoryViewController.swift
//  Todoey2
//
//  Created by Morgan Hondros on 2/12/19.
//  Copyright © 2019 Morgan Hondros. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CatergoryViewController: UITableViewController  {
    
    let realm = try! Realm()
    
    
    var categories : Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 100.0

        loadCategories()

    }

    
    //MARK: - TABLEVIEW DATASOURCE METHODS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Fucking Categories Yet"
        
        cell.delegate = self
        
        return cell
        
    }
    
    
    //MARK: - TABLEVIEW DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK: - DATA MANIPULATION METHODS
    
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("OH SHIT WE TOTALLY HAVE AN ERROR SAVING THE CATEGORY: \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
    }
    
    //MARK: - ADD NEW CATEGORIES


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textfield.text!
            
            self.save(category: newCategory)
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textfield = field
            textfield.placeholder = "Add a new category"
        }
        
        present(alert, animated: true, completion: nil)
    }

    
}

//MARK: - Swipe Cell Delegate Methods

extension CatergoryViewController: SwipeTableViewCellDelegate {
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            if let categoryForDeletion = self.categories?[indexPath.row] {
                do {
                    try self.realm.write {
                        self.realm.delete(categoryForDeletion)
                    }
                } catch {
                    print("Error deleting Category, \(error)")
                }
                
            }
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    
    
}
