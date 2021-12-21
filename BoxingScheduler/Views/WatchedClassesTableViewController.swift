//
//  WatchedClassesTableViewController.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/17/21.
//

import UIKit
import Combine

class WatchedClassesTableViewController: UITableViewController {
    var selectedClasses: [MbaClass]? {
        didSet {
            if let selectedClasses = selectedClasses {
                WatchedClasses().current = selectedClasses
            } else {
                WatchedClasses().current = []
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Watched Classes"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        if selectedClasses != nil && selectedClasses?.isEmpty == false {
            self.navigationItem.rightBarButtonItem = self.editButtonItem
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let currentClasses = DataStorage().retrieve() {
            selectedClasses = currentClasses
            tableView.reloadData()
        } else {
            print("No selectedClasses saved")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Ideally this would ahve multiple sections sorted by date as in the previous view
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedClasses!.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = selectedClasses![indexPath.row].name

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let classToDelete = selectedClasses?[indexPath.row]
//            WatchedClasses().removeSelections([selectedClasses![indexPath.row]])
            selectedClasses?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
