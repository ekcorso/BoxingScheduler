//
//  ScheduleViewController.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 11/30/21.
//

import UIKit
import SwiftSoup

class ScheduleViewController: UITableViewController {
    var dateList = [ClassDate]() {
        didSet {
            dateList = dateList.sorted()
            // TODO: Remove line below when done testing.
            // This line inserts a random item at the top of the list so it's easy to tell if the list is updating.
//            let randomDate = dateList.randomElement()!
//            let mbaClass = randomDate.classes[0]
//            mbaClass.spotsAvailable = 0
//            dateList.insert(randomDate, at: 0)
        }
    }
    var selectedClasses = [MbaClass]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Schedule"
        tableView.register(MbaClassTableViewCell.self, forCellReuseIdentifier: MbaClassTableViewCell.identifier)
        tableView.allowsMultipleSelection = true
        
        populateDateList()
        registerForNotifications()
        
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dateList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateList[section].classes.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionTitle = dateList[section].exactDate!.toString(format: DateHandler.longOutputFormat)
        return sectionTitle
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MbaClassTableViewCell.identifier, for: indexPath) as? MbaClassTableViewCell else {
            return UITableViewCell()
        }

        let mbaClass = dateList[indexPath.section].classes[indexPath.row]
        let classIsSelected = selectedClasses.contains(mbaClass)
        cell.configureForClass(mbaClass, classIsSelected)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailVC = ClassDetailViewController()
//        detailVC.mbaClass = dateList[indexPath.section].classes[indexPath.row]
//        navigationController?.pushViewController(detailVC, animated: true)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MbaClassTableViewCell.identifier, for: indexPath) as? MbaClassTableViewCell else {
           return
        }
        
        let mbaClass = dateList[indexPath.section].classes[indexPath.row]
        let classIsSelected = selectedClasses.contains(mbaClass)
        
        if mbaClass.spotsAvailable == 0 {
            if !classIsSelected {
                selectedClasses.append(mbaClass)
            } else {
                selectedClasses.remove(at: selectedClasses.firstIndex(of: mbaClass)!)
            }
        } else {
            if !classIsSelected {
                // This should be un-reachable
            } else {
                // Remove from selections
                selectedClasses.remove(at: selectedClasses.firstIndex(of: mbaClass)!)
            }
        }
        
        saveSelections()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let mbaClass = dateList[indexPath.section].classes[indexPath.row]
        let classIsAlreadySelected = selectedClasses.contains(mbaClass)
        
        // Select classes with 0 spots available to watch, or deselect classes that are already being watched regardless of spots available
        if mbaClass.spotsAvailable == 0 || classIsAlreadySelected {
            return indexPath
        } else {
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
    }
    
    @objc func showSettings() {
        let settingsViewController = SettingsViewController()
        self.present(settingsViewController, animated: true, completion: nil)
    }
    
    @objc func populateDateList() {
        // TODO: Could this be making the loading slow?
        Task { @MainActor in
            let dates = await Networking.fetchScheduleData()
            self.dateList += dates.filter() { !self.dateList.contains($0)}
            self.tableView.reloadData()
        }
    }
    
    func populateDateListFromNotification(_ dateList: [ClassDate]) {
        self.dateList += dateList.filter() { !self.dateList.contains($0) }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(forName: .newScheduleData, object: nil, queue: nil) { (notification) in
            if let userInfo = notification.userInfo, let schedule = userInfo["schedule"] as? [ClassDate] {
                self.populateDateListFromNotification(schedule)
            }
        }
    }
    
    func saveSelections() {
        print("Saving \(selectedClasses.count) classes")
        WatchedClasses().setCurrentWatched(selectedClasses)
    }
}
