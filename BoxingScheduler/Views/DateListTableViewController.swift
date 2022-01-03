//
//  ClassListTableViewController.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 11/30/21.
//

import UIKit
import SwiftSoup

class DateListTableViewController: UITableViewController {
    var dateList = [ClassDate]() {
        didSet {
            dateList = dateList.sorted()
        }
    }
    var selectedClasses = [MbaClass]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Schedule"
        tableView.register(MbaClassTableViewCell.self, forCellReuseIdentifier: MbaClassTableViewCell.identifier)
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.allowsSelection = false
        
        populateDateList()
        
        let tenMinnutes = TimeInterval(10 * 60)
        Timer.scheduledTimer(timeInterval: tenMinnutes, target: self, selector: #selector(populateDateList), userInfo: nil, repeats: true)
        
        configureNavBarButtons()
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
            // disable selection for rows that shouldn't be selectable
            return nil
        }
    }
        
    // MARK: - Actions
    
    func configureNavBarButtons() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(showSettings))
        self.navigationItem.rightBarButtonItem = editButtonItem
        if tableView.isEditing == true {
            editButtonItem.action = #selector(submitSelections)
        } else {
            editButtonItem.action = #selector(startEditing)
            editButtonItem.title = "Select"
        }
    }
    
    @objc func showSettings() {
        let settingsViewController = SettingsViewController()
        self.present(settingsViewController, animated: true, completion: nil)
    }
    
    @objc func populateDateList() {
        let fetcher = ScheduleFetcher()
        fetcher.getUrlContent() { dates in
            self.dateList += dates
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
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
