//
//  ClassListTableViewController.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 11/30/21.
//

import UIKit
import SwiftSoup

class DateListTableViewController: UITableViewController {
    var dateList = [ClassDate]()
    var selectedClasses = [MbaClass]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Available Classes"
        tableView.register(MbaClassTableViewCell.self, forCellReuseIdentifier: MbaClassTableViewCell.identifier)
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.allowsSelection = false
        
        let fetcher = ScheduleFetcher()
        fetcher.getUrlContent() { dates in
            self.dateList = dates
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        self.navigationItem.rightBarButtonItem = editButtonItem
        if tableView.isEditing == true {
            editButtonItem.action = #selector(submitSelections)
        } else {
            editButtonItem.action = #selector(startEditing)
            editButtonItem.title = "Select"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let currentlySelected = DataStorage().retrieve() {
            selectedClasses = currentlySelected
            tableView.reloadData()
        } else {
            print("No saved classes retreived")
        }
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
        if mbaClass.spotsAvailable == 0 && !selectedClasses.contains(where: { $0 == mbaClass }) {
            selectedClasses.append(mbaClass)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let mbaClass = dateList[indexPath.section].classes[indexPath.row]
        if mbaClass.spotsAvailable == 0 && !selectedClasses.contains(where: { $0 == mbaClass }) {
            return true
        } else {
            return false
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let mbaClass = dateList[indexPath.section].classes[indexPath.row]
        if mbaClass.spotsAvailable == 0 && !selectedClasses.contains(where: { $0 == mbaClass }) {
            return indexPath
        } else {
            // disable selection for row's that shouldn't be selectable
            return nil
        }
    }
        
    // MARK: - Actions
    
    @objc func startEditing() {
        tableView.isEditing.toggle()
        self.editButtonItem.title = "Submit"
        self.editButtonItem.action = #selector(submitSelections)
        print("Editing enabled")
    }
    
    @objc func submitSelections() {
        tableView.isEditing.toggle()
        self.editButtonItem.action = #selector(startEditing)
        self.editButtonItem.title = "Select"
        
        do {
            try DataStorage().save(selectedClasses)
        } catch {
            print("Saving classList failed in DateListTableViewController")
        }
        
        let vc = WatchedClassesTableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
