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
    let availableClassesViewController = NowAvailableTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateListViewController.tabBarItem = UITabBarItem(title: "Schedule", image: UIImage(systemName: "calendar"), tag: 1)
        watchedClassesViewController.tabBarItem = UITabBarItem(title: "Watched Classes", image: UIImage(systemName: "eye"), tag: 0)
        
        availableClassesViewController.tabBarItem = UITabBarItem(title: "Available Classes", image: UIImage(systemName: "list.star"), tag: 2)
        
        viewControllers = [availableClassesViewController, watchedClassesViewController, dateListViewController].map { UINavigationController(rootViewController: $0) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Is this updating the value of selectedClasses, or is that updated in the WatchedClasses vc itself?
        if let selectedClasses = DataStorage().retrieve() {
            watchedClassesViewController.selectedClasses = selectedClasses
        }
    }
}
