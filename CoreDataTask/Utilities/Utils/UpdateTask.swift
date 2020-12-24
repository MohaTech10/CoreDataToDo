//
//  UpdateTask.swift
//  CoreDataTask
//
//  Created by Mohammed mohsen on 24/12/2020.
//

import UIKit
class UpdateTask: TaskBehaviour {
    func createUpdataAPI(withTitle: String, task: Task?, completion: (Error?) -> void) {
        print("DEBUG")
        task?.taskTitle = withTitle
        do {
            try context.save()
            completion(nil)
        } catch {
            completion(error)
        }
    }
}
