//
//  FavouriteVC.swift
//  CoreDataTask
//
//  Created by Mohammed mohsen on 21/12/2020.
//

import UIKit
import CoreData
class FavouriteVC: UITableViewController {
    

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favouriteTasks = [Task]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavourites()
    }
    fileprivate func fetchFavourites() {
        let request = Task.fetchRequest() as NSFetchRequest<Task>
        
        let queryset = NSPredicate(format: "isFavourite == true")
        request.predicate = queryset
        do {
            favouriteTasks = try context.fetch(request)
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        } catch {
            print("Couldn't fetch favourite tasks")
        }
    }
    
    fileprivate func setupTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favouriteTasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = favouriteTasks[indexPath.row].taskTitle
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let unfavourite = UIContextualAction(style: .normal, title: "Unfavourite") { [weak self] action, view , completion in
            let taskToUnfavourite = self?.favouriteTasks[indexPath.row]
            taskToUnfavourite?.isFavourite = false
            do {
                try self?.context.save()
                self?.favouriteTasks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .bottom)
            } catch {
                print("Couldn't remove properly")
            }
            
        }
        unfavourite.backgroundColor = .systemOrange
        return UISwipeActionsConfiguration(actions: [unfavourite])
    }
}
