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
                print(stringData)
            }
        }
        
        dataTask.resume()
        
        return dataTask
    }
    
    func parseHtml(fromString: String) -> String? {
        do {
            let html: String = fromString
            let doc: Document = try SwiftSoup.parse(html)
            return try doc.text()
        } catch Exception.Error(let type, let message) {
            print(message)
            return nil
        } catch {
            print("error")
            return nil
        }
    }
}

