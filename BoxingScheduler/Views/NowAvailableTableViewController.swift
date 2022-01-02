//
//  NowAvailableTableViewController.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 12/23/21.
//

import UIKit

class NowAvailableTableViewController: UITableViewController {
    var availableClasses: [MbaClass]?
    
    var scheduleNowButton: UIButton = {
        let floatingButton = UIButton()
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        populateAvailableClasses()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableClasses?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NowAvailableCell.identifier, for: indexPath) as? NowAvailableCell else {
            return UITableViewCell()
        }
        
        let mbaClass = availableClasses![indexPath.row]
        cell.setCellText(mbaClass: mbaClass)
        
        return cell
    }
    
    func populateAvailableClasses() {
        let watchedClasses = WatchedClasses()
        watchedClasses.getAllClasses() { allClassList in
            let nowAvailableClasses = watchedClasses.getNowAvailableClasses(from: allClassList)
            self.availableClasses = nowAvailableClasses
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
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
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
