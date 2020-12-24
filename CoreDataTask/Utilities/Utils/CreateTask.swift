//
//  CreateTask.swift
//  CoreDataTask
//
//  Created by Mohammed mohsen on 24/12/2020.
//

import UIKit

class CreateTask: TaskBehaviour {
    
    
    func createUpdataAPI(withTitle: String, task: Task?, completion: (Error?) -> void) {
        let newTask = Task(context: context)
        newTask.taskTitle = withTitle
        do {
            try context.save()
            completion(nil)
        } catch {
            completion(error)
        }
    }
}
