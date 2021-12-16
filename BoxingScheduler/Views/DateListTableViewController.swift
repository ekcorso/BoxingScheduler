//
//  ClassListTableViewController.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 11/30/21.
//

import UIKit
import SwiftSoup

class DateListTableViewController: UITableViewController {
    var dateList = [Date]()
    var selectedClasses = [MbaClass]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Classes Available"
        tableView.register(MbaClassTableViewCell.self, forCellReuseIdentifier: MbaClassTableViewCell.identifier)
        tableView.allowsMultipleSelection = true
        //tableView.allowsMultipleSelectionDuringEditing = true
        
        let fetcher = ScheduleFetcher()
        fetcher.getUrlContent() { dates in
            self.dateList = dates
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        self.navigationItem.rightBarButtonItem = editButtonItem
        editButtonItem.title = "Select"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dateList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateList[section].classes.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dateList[section].exactDate!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MbaClassTableViewCell.identifier, for: indexPath) as? MbaClassTableViewCell else {
            return UITableViewCell()
        }

        let mbaClass = dateList[indexPath.section].classes[indexPath.row]
        cell.setCellText(mbaClass: mbaClass)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailVC = ClassDetailViewController()
//        detailVC.mbaClass = dateList[indexPath.section].classes[indexPath.row]
//        navigationController?.pushViewController(detailVC, animated: true)
        let mbaClass = dateList[indexPath.section].classes[indexPath.row]
        selectedClasses.append(mbaClass)
    }
        
    // MARK: - Actions
    
}
