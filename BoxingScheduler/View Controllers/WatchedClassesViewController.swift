//
//  WatchedClassesViewController.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/17/21.
//

import UIKit
import Combine

class WatchedClassesViewController: UITableViewController {
    var selectedClasses: [MbaClass]? {
        didSet {
            if let selectedClasses = selectedClasses {
                WatchedClasses().current = selectedClasses.sorted()
            } else {
                WatchedClasses().current = []
            }
        }
    }
    
    private let image = UIImage(systemName: "eye")!.withRenderingMode(.alwaysTemplate)
    private let topMessage = "Watched Classes"
    private let bottomMessage = "You don't have any watched classes yet. As you select classes from the schedule they will show up here."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Watched Classes"
        tableView.register(WatchedClassesCell.self, forCellReuseIdentifier: WatchedClassesCell.identifier)
        view.layoutIfNeeded()
        view.setNeedsLayout()
        setupEmptyBackgroundView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        populateSelectedClasses()
        configureRefreshControl()
        
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
        guard let selectedClasses = selectedClasses else {
            return 1
        }
        
        if selectedClasses.count == 0 {
            tableView.separatorStyle = .none
            tableView.backgroundView?.isHidden = false
        } else {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView?.isHidden = true
        }
       
        return selectedClasses.count
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
    
    // MARK: - Actions
    
    func configureRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl!)
        refreshControl?.addTarget(self, action: #selector(refreshWatchedClasses), for: .valueChanged)
    }
    
    @objc func refreshWatchedClasses() {
        populateSelectedClasses()
        tableView.reloadData()
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
        }
    }
    
    func populateSelectedClasses() {
        if let currentClasses = DataStorage().retrieve() {
            selectedClasses = currentClasses.sorted()
            tableView.reloadData()
        } else {
            print("No selectedClasses saved")
        }
    }
    
    func setupEmptyBackgroundView() {
        let emptyBackgroundView = EmptyBackgroundView(image: image, top: topMessage, bottom: bottomMessage)
        tableView.backgroundView = emptyBackgroundView
    }
}