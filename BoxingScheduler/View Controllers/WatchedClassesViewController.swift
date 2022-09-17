//
//  WatchedClassesViewController.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/17/21.
//

import UIKit
import Combine

class WatchedClassesViewController: UITableViewController {
    // This is the actual date source
    var selectedClasses: [MbaClass]? {
        didSet {
            if let selectedClasses = selectedClasses {
                WatchedClasses().setCurrentWatched(selectedClasses.sorted())
            }
        }
    }
    
    // This creates sections in the data source
    var classesByDate: [ClassDate]?
    
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
        
        self.selectedClasses = DataStorage().retrieve()?.sorted()
        
        populateSelectedClasses() {
            DispatchQueue.main.async {
                self.classesByDate = self.createClassDatesFromClasses()
                self.tableView.reloadData()
            }
        }
        
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
        
        if let selected = selectedClasses {
            let mbaClass = selected[indexPath.row]
            cell.setCellText(mbaClass: mbaClass)
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let selected = selectedClasses {
//                let classToDelete = selected[indexPath.row]
                selectedClasses!.remove(at: indexPath.row) // safe to force unwrap because we already unwrapped this in order to get here
                WatchedClasses().setCurrentWatched(selected)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // don't implicitly unwrap here as the datasource may be nil the first time the tableView tries to render
        let sectionTitle = classesByDate?[section].exactDate?.toString(format: DateHandler.longOutputFormat)
        return sectionTitle
    }
    
    // MARK: - Actions
    
    private func createClassDatesFromClasses() -> [ClassDate] {
        guard let selectedClasses = selectedClasses else {
            return []
        }
        var classDateArray = [ClassDate]()
        
        let classesByDate = Dictionary(grouping: selectedClasses, by: { $0.date })
        
        for (key, value) in classesByDate {
            classDateArray.append(ClassDate(date: key, classes: value))
        }
        
        return classDateArray.sorted()
    }
    
    func configureRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl!)
        refreshControl?.addTarget(self, action: #selector(refreshWatchedClasses), for: .valueChanged)
    }
    
    @objc func refreshWatchedClasses() {
        populateSelectedClasses() {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    func populateSelectedClasses(completion: @escaping () -> ()) {
        Task {
            self.selectedClasses = await WatchedClasses().getCurrentWatched()
            completion()
        }
    }
    
    func setupEmptyBackgroundView() {
        let emptyBackgroundView = EmptyBackgroundView(image: image, top: topMessage, bottom: bottomMessage)
        tableView.backgroundView = emptyBackgroundView
    }
}
