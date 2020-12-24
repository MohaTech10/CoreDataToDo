//
//  TaskBehaviour.swift
//  CoreDataTask
//
//  Created by Mohammed mohsen on 24/12/2020.
//

import UIKit


protocol TaskBehaviour {
    func createUpdataAPI(withTitle: String, task: Task?, completion: (Error?) -> void)
}


extension TaskBehaviour {
    func createUpdataAPI(withTitle: String, completion: (Error?) -> void) {
        createUpdataAPI(withTitle: withTitle, task: nil , completion: completion)
    }
    
}
//protocol SomeDelegate {
//    // with the completion parameter
//    func slideToRight(currentViewController viewController: UIViewController, completion: ((Bool)->())?)
//}
//
//extension SomeDelegate {
//    // without the completion parameter
//    func slideToRight(currentViewController viewController: UIViewController) {
//        slideToRight(slideToRight(currentViewController: viewController, completion: nil))
//    }


