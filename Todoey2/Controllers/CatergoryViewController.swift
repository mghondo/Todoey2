//
//  CatergoryViewController.swift
//  Todoey2
//
//  Created by Morgan Hondros on 2/12/19.
//  Copyright © 2019 Morgan Hondros. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CatergoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    
    var categories = [Category]()
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

//        loadCategories()

    }

    
    //MARK: - TABLEVIEW DATASOURCE METHODS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
        
    }
    
    
    //MARK: - TABLEVIEW DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
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
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//        do {
//        try categories = context.fetch(request)
//        } catch {
//            print("FUCKING SHIT THERE'S AN ERROR LOADING THE CATEGORIES: \(error)")
//        }
//
//        tableView.reloadData()
    }
    
    //MARK: - ADD NEW CATEGORIES


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textfield.text!
            
            self.categories.append(newCategory)
            
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
