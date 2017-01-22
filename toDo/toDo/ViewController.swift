//
//  ViewController.swift
//  toDo
//
//  Created by Dadanov Alexey on 21.12.16.
//  Copyright © 2016 Dadanov Alexey. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var items: [NSManagedObject] = []
    
    
    @IBOutlet weak var listTableView: UITableView!
    @IBAction func addItem(_ sender: Any) {
        alert()
        
    }
    @IBAction func editTapped(_ sender: Any) {
       
        if (listTableView.isEditing == true) {
            listTableView.setEditing(false, animated: true)
        } else {
            listTableView.setEditing(true, animated: true)
        }

        print("lala")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.dataSource = self
        listTableView.delegate = self
    }
    
    func alert() {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.keyboardAppearance = .dark
            textField.placeholder = "enter your item name"
        }
        
        let add = UIAlertAction(title: "add", style: .default) {
            (action) in
            let textField = alert.textFields![0] 
            self.save(name: textField.text!)
            self.listTableView.reloadData()
        }
        let cancel = UIAlertAction(title: "cancel", style: .cancel) {
            (alert) in
            
        }
        alert.addAction(add)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "itemCell") as! itemTableViewCell
        let person = items[indexPath.row]
        cell.itemLabel.text = person.value(forKey: "name") as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
        items.remove(at: indexPath.row)
        listTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        let itemToMove = items[fromIndexPath.row]
        items.remove(at: fromIndexPath.row)
        items.insert(itemToMove, at: toIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func save(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        person.setValue(name, forKeyPath: "name")
        
        do {
            try managedContext.save()
            items.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        do {
            items = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
}



