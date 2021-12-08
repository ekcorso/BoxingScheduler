//
//  ViewController.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 11/30/21.
//

import UIKit
import SwiftSoup

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUrlContent()
        
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
                //print(stringData!)
                self.createDateList(from: stringData!)
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
//            let date = try doc.select(".class-date-row")[0].text()
//            let className = try doc.select(".class-name")[0].text()
//            let spotsAvailable = try doc.select(".num-slots-available-container")[0].text()
//            return "\(date) \(className) \(spotsAvailable)"
        } catch Exception.Error(let type, let message) {
            print(message)
            return nil
        } catch {
            print("error")
            return nil
        }
    }
    
    func createDateList(from doc: Document) -> [Date] {
        let dateArray = [Date]()
        guard let elements = try? doc.getElementsByClass("class-date-row") else {
            print("getElementsByClass failed")
            return dateArray
        }
        
        for item in elements {
            do {
                let date = try Date(exactDate: item.text(), classes: [MbaClass]())
                print(date.exactDate)
            } catch {
                print("accessing element text failed")
            }
        }
        
        return dateArray    }
}

