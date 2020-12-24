//
//  MainTabBar.swift
//  TaskCoreData
//
//  Created by Mohammed mohsen on 20/12/2020.
//

import UIKit

class MainTabBar: UITabBarController {
    // MARK: Properties
    let buttonSize = 58
    private lazy var createTaskB : UIButton = {
        
        let b = UIButton(type: .system)
        b.addTarget(self , action: #selector(pushTaskCreate), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("+", for: .normal)
        b.layer.cornerRadius = CGFloat(buttonSize / 2)
        b.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        b.backgroundColor = .green
        return b
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupSubviews()
    }
    fileprivate func setupTabBar() {
        
        let taskVC = generateNavController(vc: TaskVC(), navTitle: "Tasks", barTitle: "Tasks", withImage: nil)
        let favouriteVC = generateNavController(vc: FavouriteVC(), navTitle: "Favourites", barTitle: "Favourites", withImage: nil)
        viewControllers = [taskVC, favouriteVC]
        
    }
    
    fileprivate func generateNavController(vc: UIViewController, navTitle: String, barTitle: String, withImage image: UIImage?) -> UINavigationController {
        
        vc.navigationItem.title = navTitle
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.title = barTitle
        if let image = image {
            navigationController.tabBarItem.image = image
            
        }
        return navigationController
    }
    fileprivate func setupSubviews() {
        view.addSubview(createTaskB)
        [
            createTaskB.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            createTaskB.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            createTaskB.widthAnchor.constraint(equalToConstant: CGFloat(buttonSize)),
            createTaskB.heightAnchor.constraint(equalToConstant: CGFloat(buttonSize)),
        ].forEach { (c) in
            c.isActive = true
        }
    }
    
    @objc func pushTaskCreate() {
        let taskCreateVC = UINavigationController(rootViewController: TaskCreateVC())
        taskCreateVC.modalTransitionStyle = .flipHorizontal
        taskCreateVC.modalPresentationStyle = .fullScreen
        
        self.present(taskCreateVC, animated: true)
    }
    
}
