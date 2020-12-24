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
        b.titleLabel?.font = .systemFont(ofSize: 28, weight: .medium)
        b.tintColor = .white
        b.backgroundColor = .systemBlue
        
        return b
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupSubviews()
    }
    fileprivate func setupTabBar() {

        
        let taskImage = UIImage(systemName: "list.bullet.rectangle")
        let favImage = UIImage(systemName: "star.leadinghalf.fill")
        let taskVC = generateNavController(vc: TaskVc(), navTitle: "Tasks", barTitle: "Tasks", withImage: taskImage)
        let favouriteVC = generateNavController(vc: FavouriteVC(), navTitle: "Favourites", barTitle: "Favourites", withImage: favImage)
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
//        let taskBehav = Create()
        let taskCreateVC = UINavigationController(rootViewController: TaskCreateVC())
        taskCreateVC.modalTransitionStyle = .flipHorizontal
        taskCreateVC.modalPresentationStyle = .fullScreen
        self.present(taskCreateVC, animated: true)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if selectedIndex == 0 {
            createTaskB.isHidden = true
        } else {
            createTaskB.isHidden = false
        }
        
//            createTaskB.setTitle("&", for: .normal)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
//                self.createTaskB.isHidden = false
//            }
//            // async code down it
//        } else {
//            createTaskB.setTitle("+", for: .normal)
//            createTaskB.isHidden = false
//        }
        
    }
    
}
