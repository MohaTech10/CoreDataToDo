//
//  TaskCreateVC.swift
//  TaskCoreData
//
//  Created by Mohammed mohsen on 21/12/2020.
//

import UIKit

class TaskCreateVC: UIViewController {
    var taskBehaviour: TaskBehaviour
    var navTitle: TaskEnum = .create
    internal let textView: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 20, weight: .light)
        return tv
    }()
    init() {
        self.taskBehaviour = CreateTask()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        textView.backgroundColor = .tertiaryLabel;
        view.backgroundColor = .systemBackground
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        [
            textView.topAnchor.constraint(equalTo: view.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ].forEach({$0.isActive = true})
        
        self.navigationItem.rightBarButtonItem = .init(title: navTitle.rawValue, style: .plain, target: self, action: #selector(dismisal))
        navigationItem.leftBarButtonItem = .init(title: "back", style: .plain, target: self, action: #selector(backButton))
        
        // Do any additional setup after loading the view.
    }
    
    @objc func dismisal() {
        if textViewShouldEndEditing(textView) {
            
            taskBehaviour.createUpdataAPI(withTitle: textView.text) { possibleError -> void in
                if let e = possibleError {
                    print(e.localizedDescription)
                    return
                }
                self.dismiss(animated: true)
            }
        }
    }
    @objc func backButton() {
        self.dismiss(animated: true)
    }
}
extension TaskCreateVC : UITextViewDelegate {
    
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text != "" {
            return true
        }
        return false
    }
    
}

