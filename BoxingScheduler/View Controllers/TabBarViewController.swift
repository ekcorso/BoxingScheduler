//
//  TabBarViewController.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/20/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    let dateListViewController = ScheduleViewController()
    let watchedClassesViewController = WatchedClassesViewController()
    let availableClassesViewController = NowAvailableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateListViewController.tabBarItem = UITabBarItem(title: "Schedule", image: UIImage(systemName: "calendar"), tag: 1)
        watchedClassesViewController.tabBarItem = UITabBarItem(title: "Watched Classes", image: UIImage(systemName: "eye"), tag: 0)
        
        availableClassesViewController.tabBarItem = UITabBarItem(title: "Available Classes", image: UIImage(systemName: "list.star"), tag: 2)
        
        viewControllers = [availableClassesViewController, watchedClassesViewController, dateListViewController].map { UINavigationController(rootViewController: $0) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
