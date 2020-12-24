//
//  TaskUpdateVC.swift
//  CoreDataTask
//
//  Created by Mohammed mohsen on 21/12/2020.
//

import UIKit

class TaskUpdateVC: TaskCreateVC {
    
    deinit {
        print("DEinit")
    }
    var task: Task?
    
    init(task: Task) {
        super.init()
        taskBehaviour = UpdateTask()  // Strategy pattern
        self.task = task
        navTitle = .update
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = task?.taskTitle
    }
    
    override func dismisal() {
        if textViewShouldEndEditing(textView) {
            taskBehaviour.createUpdataAPI(withTitle: self.textView.text, task: task) { e -> void in
                if let e = e {
                    print(e.localizedDescription)
                    return
                }
                dismiss(animated: true)
            }
        } else {
            print("You should change/update your task to commit changes")
        }
    }
    
    override func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        let trimmedText = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedTitle = task?.taskTitle?.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedText == trimmedTitle {
            return false
        }
        return true
    }
}
