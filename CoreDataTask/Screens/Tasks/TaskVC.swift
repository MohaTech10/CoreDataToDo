//
//  TaskVC2.swift
//  CoreDataTask
//
//  Created by Mohammed mohsen on 22/12/2020.
//

import UIKit
import CoreData
class TaskVC2: UITableViewController {
    
    
    // MARK: Properties
    var tasks = [Task]()  // change it with RedBlack/LinkedList ds
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchTasks()
    }
    
    // MARK: Helpers
    fileprivate func setupTableView() {
        self.tableView.register(TaskCell.self , forCellReuseIdentifier: TaskCell.cellId)
        tableView.backgroundColor = .systemGroupedBackground
        tableView.separatorStyle = .none
        tableView.rowHeight = 85
    }
    
    fileprivate func fetchTasks() {
        // fetch means get all the object
        let request = Task.fetchRequest() as NSFetchRequest<Task>
        do {
            tasks = try context.fetch(request)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
        } catch {
            print("Can't fetch from core data")
        }
    }

    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return tasks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellId, for: indexPath) as! TaskCell
        let task = tasks[indexPath.row]
        cell.backgroundColor = .clear
        cell.task = task
        
        cell.accessoryBackground = task.isFavourite ? .systemYellow : .lightGray
        cell.taskDelegate = self
        return cell
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}

extension TaskVC2: TaskCellDelegate {
    
    func favouriteTapped(_ cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let taskSelected = tasks[indexPath.row]
        let hasFavourite = taskSelected.isFavourite
        taskSelected.isFavourite = !hasFavourite
        do {
            try self.context.save()
            tableView.reloadRows(at: [indexPath], with: .fade)
        } catch {
            print("Couldn't save and favourite the task")
        }
    }
}
