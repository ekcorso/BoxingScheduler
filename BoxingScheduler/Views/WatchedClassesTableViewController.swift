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
        tableView.register(WatchedClassesCell.self, forCellReuseIdentifier: WatchedClassesCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let currentClasses = DataStorage().retrieve() {
            selectedClasses = currentClasses
            tableView.reloadData()
        } else {
            print("No selectedClasses saved")
        }
        
        if selectedClasses != nil && selectedClasses?.isEmpty == false {
            self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WatchedClassesCell.identifier, for: indexPath) as? WatchedClassesCell else {
            return UITableViewCell()
        }
        
        let mbaClass = selectedClasses![indexPath.row]
        cell.setCellText(mbaClass: mbaClass)
        
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
