//
//  ClassListTableViewController.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 11/30/21.
//

import UIKit
import SwiftSoup

class DateListTableViewController: UITableViewController {
    var dateList = [Date]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Classes Available"
        tableView.register(MbaClassTableViewCell.self, forCellReuseIdentifier: MbaClassTableViewCell.identifier)
        
//        DispatchQueue.main.async {
//            let fetcher = ScheduleFetcher()
//            if let dates = fetcher.dateList {
//                self.dateList = dates
//                self.tableView.reloadData()
//                print("SUCCESS")
//            }
//        }
        
        getUrlContent()

        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
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
        let detailVC = ClassDetailViewController()
        detailVC.mbaClass = dateList[indexPath.section].classes[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func getUrlContent() -> URLSessionDataTask? {
        guard let url = URL(string: "https://app.squarespacescheduling.com/schedule.php?action=showCalendar&fulldate=1&owner=19967298&template=class"), let payload = "type=&calendar=&skip=true&options%5Bqty%5D=1&options%5BnumDays%5D=5&ignoreAppointment=&appointmentType=&calendarID=".data(using: .utf8) else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "content-type")
        request.httpBody = payload

        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let data = data else {
                print("Empty data")
                return
            }
            if let str = String(data: data, encoding: .utf8) {
                let stringData = self.parseHtml(fromString: str)
                //self.createDateList(from: stringData!)
                self.dateList = self.createDateList(from: stringData!)
            }
        }

        dataTask.resume()

        return dataTask
    }

    func parseHtml(fromString: String) -> Document? {
        do {
            let html: String = fromString
            let doc: Document = try SwiftSoup.parse(html)
            return doc
        } catch Exception.Error(_, let message) {
            print(message)
            return nil
        } catch {
            print("error")
            return nil
        }
    }

    func createDateList(from doc: Document) -> [Date] {
        var dateArray = [Date]()
        guard let elements = try? doc.select("tr") else {
            print("select for tr failed")
            return dateArray
        }

        for (index, item) in elements.enumerated() {
            let date = Date()
            do {
                if item.hasClass("class-date-row") {
                    let exactDate = try item.select(".class-date-row").text()
                    date.exactDate = exactDate
                    dateArray.append(date)
                } else if try! item.className().contains("class-row-xs") {
                    let name = try item.text()
                    let spotsAvailable = try elements[index + 1].text()
                    let boxingClass = MbaClass(name: name, spotsAvailable: spotsAvailable)
                    if let previousDate = dateArray.last {
                        previousDate.classes.append(boxingClass)
                    }
                }
            } catch Exception.Error(_, let message) {
                print(message)
            } catch {
                print("other exception")
            }
        }

        for date in dateArray {
            print("Classes on date \(date.exactDate!): \(date.classes.count)")
        }

        DispatchQueue.main.async {
            self.dateList = dateArray
            self.tableView.reloadData()
        }
        return dateArray
    }

}
