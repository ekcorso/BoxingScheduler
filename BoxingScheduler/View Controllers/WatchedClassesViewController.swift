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
                self.classesByDate = WatchedClasses().createClassDatesFromClasses(self.selectedClasses) // should the top of the class have a shared reference to watchedClasses instead?
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
        return classesByDate?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let classesByDate = classesByDate else {
            return 1
        }
        
        if classesByDate.count == 0 {
            tableView.separatorStyle = .none
            tableView.backgroundView?.isHidden = false
        } else {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView?.isHidden = true
        }
       
        return classesByDate[section].classes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WatchedClassesCell.identifier, for: indexPath) as? WatchedClassesCell else {
            return UITableViewCell()
        }

        if let classesByDate = classesByDate {
            let mbaClass = classesByDate[indexPath.section].classes[indexPath.row]
            cell.setCellText(mbaClass: mbaClass)
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let selected = selectedClasses else {
                return
            }
            
            guard let dateList = classesByDate else {
                return
            }
            
            // Safe to force unwrap selectedClasses and classesByDate going forward
            let mbaClass = dateList[indexPath.section].classes[indexPath.row]
            selectedClasses!.remove(at: selected.firstIndex(of: mbaClass)!)
            WatchedClasses().setCurrentWatched(selectedClasses!)
            classesByDate![indexPath.section].classes.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // don't implicitly unwrap here as the datasource may be nil the first time the tableView tries to render
        let sectionTitle = classesByDate?[section].exactDate?.toString(format: DateHandler.longOutputFormat)
        return sectionTitle
    }
    
    // MARK: - Actions
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
