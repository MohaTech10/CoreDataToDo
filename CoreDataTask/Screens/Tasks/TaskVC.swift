//
//  TaskVC2.swift
//  CoreDataTask
//
//  Created by Mohammed mohsen on 22/12/2020.
//

import UIKit
import CoreData
class TaskVc: UITableViewController {
    
    // MARK: Properties
    var tasks = [Task]()  // change it with RedBlack/LinkedList ds
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: Lifecycle
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
    
    func deleteTask(at indexPath: IndexPath) -> void {
        let row = indexPath.row
        // get the specified object
        let deletedTask = tasks[row]
        context.delete(deletedTask)
        do {
            try context.save()
        } catch {
            print("Couldn't delete properly")
        }
        tasks.remove(at: row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellId, for: indexPath) as! TaskCell
        let task = tasks[indexPath.row]
        cell.backgroundColor = .secondarySystemGroupedBackground
//        cell.task = task
        cell.textLabel?.text = task.taskTitle
        cell.textLabel?.numberOfLines = 0
        
        cell.accessoryView?.tintColor = task.isFavourite ? .systemYellow : .lightGray
        cell.delegate = self
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTask(at: indexPath)
        }
    }
}
// MARK: TaskCellDelegate
extension TaskVc: TaskCellDelegate {
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let taskBehav = Update()  // we have two solutions
        // either dependecy injection or StrategyPattren
        let eachTask = tasks[indexPath.row]
        let taskCreateVC = UINavigationController(rootViewController : TaskUpdateVC(task: eachTask))
        taskCreateVC.modalTransitionStyle = .flipHorizontal
        taskCreateVC.modalPresentationStyle = .fullScreen
        
        self.present(taskCreateVC, animated: true)
    }
}


