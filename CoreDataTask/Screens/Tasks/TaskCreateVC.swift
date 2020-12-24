//
//  TaskCreateVC.swift
//  TaskCoreData
//
//  Created by Mohammed mohsen on 21/12/2020.
//

import UIKit

class TaskCreateVC: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private let textView = UITextView()
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.backgroundColor = .tertiaryLabel;
        view.backgroundColor = .systemBackground
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        [
            textView.topAnchor.constraint(equalTo: view.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.heightAnchor.constraint(equalToConstant: 200),
        ].forEach({$0.isActive = true})
        
        self.navigationItem.rightBarButtonItem = .init(title: "Dismiss", style: .done, target: self, action: #selector(dismisal))

        // Do any additional setup after loading the view.
    }
    
    @objc func dismisal() {
        // create an object save it and that's it
        let newTask = Task(context: context)
        newTask.taskTitle = textView.text
        do {
            try context.save()
            print("new task is added")
        } catch {
            print("Couldn't save properly")
        }
        self.dismiss(animated: true , completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
