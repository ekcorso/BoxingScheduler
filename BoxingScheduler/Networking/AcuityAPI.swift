//
//  AcuityAPI.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 11/30/21.
//

import Foundation
import SwiftSoup
import Combine

class AcuityAPI {
    private var didChange = PassthroughSubject<Document, Never>()
    private var doc: Document? {
        didSet {
            if let doc = doc {
                print("Updating doc in didSet")
            didChange.send(doc)
            }
        }
    }
//    var dateList: [Date]
    
//    init() {
//        self.dateList = createDateList() ?? [Date]()
//    }
//
    func createDateList() -> [Date]? {
        var dateArray = [Date]()
        guard let doc = doc else {
            print("no document")
            return nil
        }
        
        guard let elements = try? doc.select("tr") else {
            print("selecting for table row failed")
            return nil
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
            print("Classes on date \(date.exactDate ?? "No Date"): \(date.classes.count)")
        }
        return dateArray
    }
    
    private func getUrlContent() -> URLSessionDataTask? {
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
                if let document = self.parseHtml(fromString: str) {
                    DispatchQueue.main.async {
                        self.doc = document
                    }
                }
                //self.createDateList(from: stringData!)
            }
        }
        
        dataTask.resume()
        
        return dataTask
    }
    
    private func parseHtml(fromString: String) -> Document? {
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
}
