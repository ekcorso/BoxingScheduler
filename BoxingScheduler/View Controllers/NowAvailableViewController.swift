//
//  NowAvailableViewController.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/23/21.
//

import UIKit
import PureLayout


class NowAvailableViewController: UITableViewController {
    // This is the actual date source
    var availableClasses: [MbaClass]?
    // This creates sections in the data source
    var classesByDate: [ClassDate]?
    
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
        
        if let window = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            window.windows.first?.addSubview(floatingButton)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NowAvailableCell.identifier, for: indexPath) as? NowAvailableCell else {
            return UITableViewCell()
        }
        
        guard let classesByDate = classesByDate else {
            return UITableViewCell()
        }

        let mbaClass = classesByDate[indexPath.section].classes[indexPath.row]
        cell.setCellText(mbaClass: mbaClass)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // don't implicitly unwrap here as the datasource may be nil the first time the tableView tries to render
        let sectionTitle = classesByDate?[section].exactDate?.toString(format: DateHandler.longOutputFormat)
        return sectionTitle
    }
    
    // MARK: - Actions
    
    @objc func populateAvailableClasses() {
        let watchedClasses = WatchedClasses()
        Task {
            let allClassList = await watchedClasses.getAllClasses()
            let nowAvailableClasses = watchedClasses.filterForNowAvailableClasses(from: allClassList)
            self.availableClasses = nowAvailableClasses.sorted()
            self.classesByDate = watchedClasses.createClassDatesFromClasses(self.availableClasses)

            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }

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
