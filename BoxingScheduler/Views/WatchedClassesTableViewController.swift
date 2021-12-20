//
//  WatchedClassesTableViewController.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/17/21.
//

import UIKit

class WatchedClassesTableViewController: UITableViewController {
    var selectedClasses: [MbaClass]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Watched Classes"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.allowsMultipleSelectionDuringEditing = true
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selections = DataStorage().retrieve() {
            selectedClasses = selections
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


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

}
