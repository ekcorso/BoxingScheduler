//
//  TabBarViewController.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/20/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    let dateListViewController = DateListTableViewController()
    let watchedClassesViewController = WatchedClassesTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateListViewController.tabBarItem = UITabBarItem(title: "Schedule", image: UIImage(systemName: "calendar"), tag: 0)
        watchedClassesViewController.tabBarItem = UITabBarItem(title: "Watched Classes", image: UIImage(systemName: "list.star"), tag: 1)
        
        viewControllers = [dateListViewController, watchedClassesViewController].map { UINavigationController(rootViewController: $0) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedClasses = DataStorage().retrieve() {
            watchedClassesViewController.selectedClasses = selectedClasses
        }
    }
}
