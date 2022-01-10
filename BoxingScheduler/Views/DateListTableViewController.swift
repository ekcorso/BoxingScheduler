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
        configureRefreshControl()
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
        
        if let selections = DataStorage().retrieve() {
            if selections != self.selectedClasses {
                self.editButtonItem.title = "Submit"
                self.editButtonItem.action = #selector(submitSelections)
            }
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
    
    func configureRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl!)
        refreshControl?.addTarget(self, action: #selector(refreshScheduleDateList), for: .valueChanged)
    }
    
    @objc func refreshScheduleDateList() {
        populateDateList()
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
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
        let fetcher = Networking()
        fetcher.fetchScheduleData() { [self] dates in
            // Check that dateList doesn't already contain these dates. If it doesn't, add them.
            self.dateList += dates.filter() { !self.dateList.contains($0) }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func startEditing() {
        tableView.isEditing.toggle()
        self.editButtonItem.title = "Done"
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
        
        let ac = UIAlertController(title: "Class Selections Submitted", message: "You can view/ edit your selections in the Watched Classes tab", preferredStyle: .alert)
        let seeWatchedClasses = UIAlertAction(title: "See Watched Classes", style: .default) { _ in
            // Navigate to the watchedClasses tab
            self.tabBarController?.selectedIndex = 1
        }
        let done = UIAlertAction(title: "Done", style: .default)
        ac.addAction(seeWatchedClasses)
        ac.addAction(done)
        navigationController?.present(ac, animated: true)
    }
}
