//
//  NowAvailableViewController.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/23/21.
//

import UIKit
import PureLayout


class NowAvailableViewController: UITableViewController {
    var availableClasses: [MbaClass]?
    private let image = UIImage(systemName: "list.star")!.withRenderingMode(.alwaysTemplate)
    private let topMessage = "Now Available"
    private let bottomMessage = "You don't have any available classes yet. As classes become available they will show up here."
    
    
    var scheduleNowButton: UIButton = {
        let floatingButton = UIButton()
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.addTarget(self, action: #selector(navigateToSchedulingWebsite), for: .touchUpInside)
        floatingButton.backgroundColor = .systemGreen
        floatingButton.setTitle("Schedule Now", for: .normal)
        floatingButton.layer.cornerRadius = 25
        floatingButton.layer.borderWidth = 1
        floatingButton.layer.borderColor = UIColor.systemGray2.cgColor
        // TODO: Figure out why this button isn't opaque
        if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
            window.addSubview(floatingButton)
        }
        return floatingButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(NowAvailableCell.self, forCellReuseIdentifier: NowAvailableCell.identifier)
        title = "Available Classes"
        tableView.addSubview(scheduleNowButton)
        constrainButton()
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        configureRefreshControl()
        setupEmptyBackgroundView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        populateAvailableClasses()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if availableClasses?.count == 0 {
            tableView.separatorStyle = .none
            tableView.backgroundView?.isHidden = false
        } else {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView?.isHidden = true
        }
        
        return availableClasses?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NowAvailableCell.identifier, for: indexPath) as? NowAvailableCell else {
            return UITableViewCell()
        }
        
        guard let availableClasses = availableClasses else {
            return UITableViewCell()
        }

        let mbaClass = availableClasses[indexPath.row]
        cell.setCellText(mbaClass: mbaClass)
        
        return cell
    }
    
    @objc func populateAvailableClasses() {
        let watchedClasses = WatchedClasses()
        Task {
            let allClassList = await watchedClasses.getAllClasses()
            let nowAvailableClasses = watchedClasses.getNowAvailableClasses(from: allClassList)
            self.availableClasses = nowAvailableClasses.sorted()

            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }
    /*
    func populateNowAvailableFromNotification(_ newAvailableClasses: [MbaClass]) {
        print("Got to populateNoteAvailableClassesFromNotification")
        if let existingAvailableClasses = self.availableClasses {
            self.availableClasses! += newAvailableClasses.filter() { !availableClasses!.contains($0) }
        } else {
            self.availableClasses = newAvailableClasses
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(forName: .newScheduleData, object: nil, queue: nil) { (notification) in
            if let userInfo = notification.userInfo, let availableClasses = userInfo["availableClasses"] as? [MbaClass] {
                self.populateNowAvailableFromNotification(availableClasses)
            }
        }
    }
    */
    
    func constrainButton() {
        NSLayoutConstraint.activate([
            scheduleNowButton.heightAnchor.constraint(equalToConstant: 50),
            scheduleNowButton.widthAnchor.constraint(equalToConstant: 150),
            scheduleNowButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
            scheduleNowButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10),
        ])
    }
    
    @objc func navigateToSchedulingWebsite() {
        let vc = WebViewController()
        present(vc, animated: true)
        
    }
    
    func configureRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl!)
        refreshControl?.addTarget(self, action: #selector(populateAvailableClasses), for: .valueChanged)
    }
    
    func setupEmptyBackgroundView() {
        let emptyBackgroundView = EmptyBackgroundView(image: image, top: topMessage, bottom: bottomMessage)
        tableView.backgroundView = emptyBackgroundView
    }
}
